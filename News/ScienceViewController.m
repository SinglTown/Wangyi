//
//  ScienceViewController.m
//  SliderDemo
//
//  Created by lanou3g on 15/12/20.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "ScienceViewController.h"
#import "NewsTableViewCell.h"
#import "ThreeImagesTableViewCell.h"
#import "NewsDataManager.h"
#import "NewsModel.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "CoreDataHandle.h"
@interface ScienceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *scienceTableView;

@end

@implementation ScienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scienceTableView.dataSource = self;
    self.scienceTableView.delegate = self;
    
    [self.scienceTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.scienceTableView registerNib:[UINib nibWithNibName:@"ThreeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ThreeImagesTableViewCell"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kScienceString withblock:^{
        if ([defaults boolForKey:@"third"] == NO) {
            NSArray *array = [NewsDataManager sharedNewsDataManager].scienceNewsDataArray;
            for (NewsModel *model in array) {
                [[CoreDataHandle sharedCoreDataHandle] insertNewsDataWithModel:model];
            }
            [defaults setBool:YES forKey:@"third"];
        }
        [self.scienceTableView reloadData];
    }];
    
    [self setupRefresh];
}
-(void)setupRefresh
{
    //下拉刷新
    [self.scienceTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.scienceTableView headerBeginRefreshing];
    self.scienceTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.scienceTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.scienceTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.scienceTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.scienceTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kScienceString withblock:^{
        [self.scienceTableView reloadData];
    }];
    
    
    [self.scienceTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kScienceString withblock:^{
        [self.scienceTableView reloadData];
    }];
    
    [self.scienceTableView footerEndRefreshing];
}


#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].scienceNewsDataArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [NewsDataManager sharedNewsDataManager].scienceNewsDataArray[indexPath.row];
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
#pragma mark - 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    NewsModel *model = [NewsDataManager sharedNewsDataManager].scienceNewsDataArray[indexPath.row];
    detailVC.urlString = model.url;
    [self.navigationController pushViewController:detailVC animated:YES];

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
