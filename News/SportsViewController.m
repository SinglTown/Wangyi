//
//  SportsViewController.m
//  SliderDemo
//
//  Created by lanou3g on 15/12/20.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "SportsViewController.h"
#import "NewsDataManager.h"
#import "NewsTableViewCell.h"
#import "ThreeImagesTableViewCell.h"
#import "NewsModel.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "CoreDataHandle.h"
@interface SportsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *sportsTableView;

@end

@implementation SportsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sportsTableView.dataSource = self;
    self.sportsTableView.delegate = self;
    
    [self.sportsTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.sportsTableView registerNib:[UINib nibWithNibName:@"ThreeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ThreeImagesTableViewCell"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kSportsString withblock:^{
        if ([defaults boolForKey:@"second"] == NO) {
            NSArray *array = [NewsDataManager sharedNewsDataManager].sportsNewsDataArray;
            for (NewsModel *model in array) {
                [[CoreDataHandle sharedCoreDataHandle] insertNewsDataWithModel:model];
            }
            [defaults setBool:YES forKey:@"second"];
        }
        [self.sportsTableView reloadData];
    }];
    
    [self setupRefresh];
}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉刷新
    [self.sportsTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.sportsTableView headerBeginRefreshing];
    self.sportsTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.sportsTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.sportsTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.sportsTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.sportsTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.sportsTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.sportsTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kSportsString withblock:^{
        [self.sportsTableView reloadData];
    }];
    
    
    [self.sportsTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
    [[NewsDataManager sharedNewsDataManager] getDataWithUrlString:kSportsString withblock:^{
        [self.sportsTableView reloadData];
    }];
    
    [self.sportsTableView footerEndRefreshing];
}

#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].sportsNewsDataArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [NewsDataManager sharedNewsDataManager].sportsNewsDataArray[indexPath.row];
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
    NewsModel *model = [NewsDataManager sharedNewsDataManager].sportsNewsDataArray[indexPath.row];
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
