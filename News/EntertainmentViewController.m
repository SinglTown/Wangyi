//
//  EntertainmentViewController.m
//  News
//
//  Created by lanou3g on 15/12/21.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "EntertainmentViewController.h"
#import "NewsTableViewCell.h"
#import "NewsDataManager.h"
#import "NewsModel.h"
#import "ThreeImagesTableViewCell.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "NewsViewController.h"
#import "DetailViewController.h"
#import "CoreDataHandle.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface EntertainmentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *entertainmentTableView;

//webView
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation EntertainmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.entertainmentTableView.dataSource = self;
    self.entertainmentTableView.delegate = self;
    
    //注册标记
    [self.entertainmentTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.entertainmentTableView registerNib:[UINib nibWithNibName:@"ThreeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ThreeImagesTableViewCell"];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //解析数据
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kEntertainmentString withblock:^{
        if ([defaults boolForKey:@"first"] == NO) {
            NSArray *array = [NewsDataManager sharedNewsDataManager].entertainNewsDataArray;
            for (NewsModel *model in array) {
                [[CoreDataHandle sharedCoreDataHandle] insertNewsDataWithModel:model];
            }
            [defaults setBool:YES forKey:@"first"];
        }
        
        [self.entertainmentTableView reloadData];
    }];
    
    //开始刷新数据
    [self setupRefresh];

}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉刷新
    [self.entertainmentTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.entertainmentTableView headerBeginRefreshing];
    self.entertainmentTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.entertainmentTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.entertainmentTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.entertainmentTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.entertainmentTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.entertainmentTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.entertainmentTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kEntertainmentString withblock:^{
        [self.entertainmentTableView reloadData];
    }];

    
    [self.entertainmentTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kEntertainmentString withblock:^{
        [self.entertainmentTableView reloadData];
    }];

    [self.entertainmentTableView footerEndRefreshing];
}
#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].entertainNewsDataArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [NewsDataManager sharedNewsDataManager].entertainNewsDataArray[indexPath.row];
    if (model.imgextra != nil) {
        ThreeImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeImagesTableViewCell"];
        [cell getDataForCellWithModel:model];
        return cell;
    }
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell"];
    [cell setValueForCellWith:model];
    return cell;
}
#pragma mark - 设置row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark - 设置点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    NewsModel *model = [NewsDataManager sharedNewsDataManager].entertainNewsDataArray[indexPath.row];
    detailVC.urlString = model.url;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 分区数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
