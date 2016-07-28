//
//  MovieViewController.m
//  WangYi
//
//  Created by lanou3g on 15/12/17.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "NewsDataManager.h"
#import "MBProgressHUD.h"
#import "EntertainMovieViewController.h"
#import "HighQualityMovieViewController.h"
#import "MJRefresh.h"
@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
//热点
@property (strong, nonatomic) IBOutlet UIButton *hotMovieButton;
//娱乐
@property (strong, nonatomic) IBOutlet UIButton *entertainmentMovieButton;
//精品
@property (strong, nonatomic) IBOutlet UIButton *highQualityMovieButton;
@property (strong, nonatomic) IBOutlet UITableView *movieTableView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频";
    
    self.hotMovieButton.layer.cornerRadius = 25;
    self.entertainmentMovieButton.layer.cornerRadius = 25;
    self.highQualityMovieButton.layer.cornerRadius = 25;
    
    self.movieTableView.dataSource = self;
    self.movieTableView.delegate = self;
    
    [self.movieTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    [MBProgressHUD showHUDAddedTo:self.movieTableView animated:YES];
    //解析数据
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHotMovieString withBlock:^{
        [MBProgressHUD hideHUDForView:self.movieTableView animated:YES];
        [self.movieTableView reloadData];
    }];
    
    //刷新数据
    [self setupRefresh];
}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉刷新
    [self.movieTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.movieTableView headerBeginRefreshing];
    self.movieTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.movieTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.movieTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.movieTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.movieTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.movieTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.movieTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHotMovieString withBlock:^{
        [self.movieTableView reloadData];
    }];
    
    [self.movieTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHotMovieString withBlock:^{
        [self.movieTableView reloadData];
    }];
    [self.movieTableView footerEndRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHotMovieString withBlock:^{
        [self.movieTableView reloadData];
    }];
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
- (IBAction)clickHotMovieAction:(id)sender {
    
    [self setupRefresh];
}
- (IBAction)clickEntertainmentMovieAction:(id)sender {
    
    EntertainMovieViewController *entertainmentVC = [[EntertainMovieViewController alloc] init];
    [self.navigationController pushViewController:entertainmentVC animated:YES];
}
- (IBAction)clickHightQualityMovieButton:(id)sender {
    
    HighQualityMovieViewController *hqVC = [[HighQualityMovieViewController alloc] init];
    [self.navigationController pushViewController:hqVC animated:YES];
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
