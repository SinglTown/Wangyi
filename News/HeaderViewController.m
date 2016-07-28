//
//  HeaderViewController.m
//  SliderDemo
//
//  Created by lanou3g on 15/12/20.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "HeaderViewController.h"
#import "NewsTableViewCell.h"
#import "NewsDataManager.h"
#import "NewsModel.h"
#import "ThreeImagesTableViewCell.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ImagesScrollView.h"
#import "MJRefresh.h"
#import "NewsViewController.h"
#import "DetailViewController.h"
#import "Reachability.h"
#import "CoreDataHandle.h"
#import "News.h"
#import "DetailPictureViewController.h"
#import "CoreDataHandle.h"
#import "History.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface HeaderViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *headerTableView;

//轮播图的View
@property (nonatomic,strong)ImagesScrollView *imagesScrollView;

//webView
@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerTableView.dataSource = self;
    self.headerTableView.delegate = self;

    //注册标记
    [self.headerTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self.headerTableView registerNib:[UINib nibWithNibName:@"ThreeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ThreeImagesTableViewCell"];
    
    [MBProgressHUD showHUDAddedTo:self.headerTableView animated:YES];
    //解析数据
    
    
    //判断网络获取数据
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkDidChanged:) name:kReachabilityChangedNotification object:reach];
    [reach startNotifier];
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImageAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)nextImageAction:(NSTimer *)sender
{
    self.imagesScrollView.currentImageIndex = (self.imagesScrollView.currentImageIndex +1)%self.imagesScrollView.imageCount;
    [self.imagesScrollView reloadImage];
    
    self.imagesScrollView.pageControl.currentPage = self.imagesScrollView.currentImageIndex;
}
-(void)netWorkDidChanged:(NSNotification *)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    Reachability *reach = sender.object;
    //当前是否有WiFi
    [reach isReachableViaWiFi];
    //当前是否有2.3.4g网
    [reach isReachableViaWWAN];
    if ([reach isReachable]) {
        NSLog(@"网络畅通");
        //先从数据库中取出所有数据
        NSArray *array = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"News"];
        dispatch_async(queue, ^{
            [[NewsDataManager sharedNewsDataManager] getNewsDatawithBlock:^{
                [MBProgressHUD hideHUDForView:self.headerTableView animated:YES];
                NSArray *newsDataArray = [NewsDataManager sharedNewsDataManager].headerNewsDataArray;
                //判断解析后的数组是否为空
                if (newsDataArray>0) {
                    //不为空,继而判断数据库中是否为空,若为空进行插入操作
                    if (array.count == 0) {
                        //循环将数据插入数据库
                        for (NewsModel *model in newsDataArray) {
                            [[CoreDataHandle sharedCoreDataHandle] insertNewsDataWithModel:model];
                        }
                    }
                }
                [self.headerTableView reloadData];
                //开始刷新数据
                [self setupRefresh];
            }];
        });
        }else{
        NSLog(@"无网络");
        [MBProgressHUD hideHUDForView:self.headerTableView animated:YES];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前无网络" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}
#pragma mark - 刷新
-(void)setupRefresh
{
    //下拉刷新
    [self.headerTableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.headerTableView headerBeginRefreshing];
    self.headerTableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.headerTableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.headerTableView.headerRefreshingText = @"刷新中";
    //上拉加载更多
    [self.headerTableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    self.headerTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.headerTableView.footerReleaseToRefreshText = @"松开可以马上加载更多数据了";
    self.headerTableView.footerRefreshingText = @"加载中";
}
#pragma mark - 下拉刷新
-(void)headerRefreshing
{
    //一般为网络请求
    [[NewsDataManager sharedNewsDataManager] getNewsDatawithBlock:^{
        [self.headerTableView reloadData];
    }];

    [self.headerTableView headerEndRefreshing];
}
#pragma mark - 上拉刷新
-(void)footerRefreshing
{
    //一般是提取缓存的数据
    [[NewsDataManager sharedNewsDataManager] getNewsDatawithBlock:^{
        [self.headerTableView reloadData];
    }];
    [self.headerTableView footerEndRefreshing];
}
#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsDataManager sharedNewsDataManager].headerNewsDataArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = [NewsDataManager sharedNewsDataManager].headerNewsDataArray[indexPath.row];
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
    NewsModel *model = [NewsDataManager sharedNewsDataManager].headerNewsDataArray[indexPath.row];
    [[CoreDataHandle sharedCoreDataHandle] insertHistoryInforDataWithModel:model];
//    NSArray *array = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"History"];
//    NSLog(@"%@",array);
//    NSArray *array = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"History"];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([userDefaults boolForKey:@"history"] == NO) {
//        [[CoreDataHandle sharedCoreDataHandle] insertHistoryInforDataWithModel:model];
//        [userDefaults setBool:YES forKey:@"history"];
//    }
//    for (History *history in array) {
//        if ([model.title isEqualToString:history.title]) {
//            continue;
//        }
//        [[CoreDataHandle sharedCoreDataHandle] insertHistoryInforDataWithModel:model];
//    }
//    NSLog(@"----%@",array);
    if (model.imgextra != nil) {
        DetailPictureViewController *detailPictureVC = [[DetailPictureViewController alloc] init];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *d in model.imgextra) {
            NSString *imageUrl = [d valueForKey:@"imgsrc"];
            [array addObject:imageUrl];
        }
        [array addObject:model.imgsrc];
        detailPictureVC.picArray = array;
        detailPictureVC.imageTitle = model.title;
        [self.navigationController pushViewController:detailPictureVC animated:YES];
    }else{
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        
        detailVC.urlString = model.url;
        CATransition* transition = [CATransition animation];
        transition.duration = 1;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        //fade
        // 左边推进   kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        [self.navigationController pushViewController:detailVC animated:NO];
         [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}
#pragma mark - 设置header的图片
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.imagesScrollView = [[ImagesScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    [self.view addSubview:self.imagesScrollView];
    return self.imagesScrollView;
}
#pragma mark - 分区数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation(M_PI, 1, 0, 0);
////    rotation.m34 = 1.0/-600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0);
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//}
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
