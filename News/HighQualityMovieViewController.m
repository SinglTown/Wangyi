//
//  HighQualityMovieViewController.m
//  News
//
//  Created by lanou3g on 15/12/21.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "HighQualityMovieViewController.h"
#import "NewsModel.h"
#import "NewsDataManager.h"
#import "MovieTableViewCell.h"
#import "MJRefresh.h"
@interface HighQualityMovieViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *hightQualityMovieTableView;

@end

@implementation HighQualityMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hightQualityMovieTableView.dataSource = self;
    self.hightQualityMovieTableView.delegate = self;
    
    [self.hightQualityMovieTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MovieTableViewCell"];
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHightQualityString withBlock:^{
        [self.hightQualityMovieTableView reloadData];
    }];
    
    [self setupRefresh];
    
}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉
    [self.hightQualityMovieTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    self.hightQualityMovieTableView.headerRefreshingText = @"刷新中";
    [self.hightQualityMovieTableView headerBeginRefreshing];
    //上拉
    [self.hightQualityMovieTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
}
#pragma mark - 上拉刷新
-(void)headerRefreshing
{
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHightQualityString withBlock:^{
        [self.hightQualityMovieTableView reloadData];
    }];
    [self.hightQualityMovieTableView headerEndRefreshing];
}
#pragma mark - 下拉刷新
-(void)footerRefreshing
{
    [[NewsDataManager sharedNewsDataManager] GetMovieDateWithString:kHightQualityString withBlock:^{
        [self.hightQualityMovieTableView reloadData];
    }];
    [self.hightQualityMovieTableView footerEndRefreshing];
}
#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].movieArray.count-1;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    MovieModel *model = [NewsDataManager sharedNewsDataManager].movieArray[indexPath.row];
    [cell setValueForCellWithModel:model];
    return cell;
}
#pragma mark -row的高度
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
