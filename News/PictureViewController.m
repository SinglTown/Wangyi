//
//  PictureViewController.m
//  News
//
//  Created by lanou3g on 15/12/23.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "PictureViewController.h"
#import "AllScreenTableViewCell.h"
#import "RightThreeImagesTableViewCell.h"
#import "LeftThreeImagesTableViewCell.h"
#import "DetailPictureViewController.h"
#import "NewsDataManager.h"
#import "PictureModel.h"
#import "MJRefresh.h"
@interface PictureViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *pictureTableView;

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片";
    
    self.pictureTableView.dataSource = self;
    self.pictureTableView.delegate = self;
    
    [self.pictureTableView registerNib:[UINib nibWithNibName:@"AllScreenTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AllScreenTableViewCell"];
    [self.pictureTableView registerNib:[UINib nibWithNibName:@"RightThreeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RightThreeImagesTableViewCell"];
    [self.pictureTableView registerNib:[UINib nibWithNibName:@"LeftThreeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LeftThreeImagesTableViewCell"];
    
    [[NewsDataManager sharedNewsDataManager] getPictureDataWithBlock:^{
        [self.pictureTableView reloadData];
    }];
    
    [self setupRefresh];
}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉刷新
    [self.pictureTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.pictureTableView headerBeginRefreshing];
    self.pictureTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.pictureTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.pictureTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.pictureTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.pictureTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.pictureTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.pictureTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] getPictureDataWithBlock:^{
        [self.pictureTableView reloadData];
    }];
    
    [self.pictureTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
//    [[NewsDataManager sharedNewsDataManager] getPictureDataWithBlock:^{
//        [self.pictureTableView reloadData];
//    }];
    [self.pictureTableView footerEndRefreshing];
}

#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].pictureArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureModel *model = [NewsDataManager sharedNewsDataManager].pictureArray[indexPath.row];
    if (indexPath.row%3 == 0) {
        AllScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllScreenTableViewCell"];
        [cell setCellValueWithModel:model];
        return cell;
    }else if (indexPath.row%3 == 1){
        RightThreeImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightThreeImagesTableViewCell"];
        [cell setCellValueWithModel:model];
        return cell;
    }
    LeftThreeImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftThreeImagesTableViewCell"];
    [cell setCellValueWithModel:model];
    return cell;
}
#pragma mark - row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PictureModel *model = [NewsDataManager sharedNewsDataManager].pictureArray[indexPath.row];
    DetailPictureViewController *detailVC = [[DetailPictureViewController alloc] init];
    detailVC.imageTitle = model.setname;
    detailVC.desc = model.desc;
    detailVC.countOfImage = model.imgsum;
    detailVC.picArray = model.pics;
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
