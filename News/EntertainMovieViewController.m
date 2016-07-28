//
//  EntertainMovieViewController.m
//  News
//
//  Created by lanou3g on 15/12/21.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "EntertainMovieViewController.h"
#import "MovieTableViewCell.h"
#import "NewsDataManager.h"
#import "MJRefresh.h"
@interface EntertainMovieViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *enterMovieTableView;

@end

@implementation EntertainMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enterMovieTableView.dataSource = self;
    self.enterMovieTableView.delegate = self;
    
    
    [self.enterMovieTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MovieTableViewCell"];
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kEnterMovieString withBlock:^{
        [self.enterMovieTableView reloadData];
    }];
    
    [self setupRefresh];
}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉刷新
    [self.enterMovieTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.enterMovieTableView headerBeginRefreshing];
    self.enterMovieTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.enterMovieTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.enterMovieTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.enterMovieTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.enterMovieTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.enterMovieTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.enterMovieTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kEnterMovieString withBlock:^{
        [self.enterMovieTableView reloadData];
    }];
    
    [self.enterMovieTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kEnterMovieString withBlock:^{
        [self.enterMovieTableView reloadData];
    }];
    [self.enterMovieTableView footerEndRefreshing];
}

#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].movieArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    MovieModel *model = [NewsDataManager sharedNewsDataManager].movieArray[indexPath.row];
    [cell setValueForCellWithModel:model];
    return cell;
}
#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
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
