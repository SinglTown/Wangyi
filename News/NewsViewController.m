//
//  NewsViewController.m
//  News
//
//  Created by lanou3g on 15/12/20.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "NewsViewController.h"
#import "SCNavTabBarController.h"
#import "HeaderViewController.h"
#import "EntertainmentViewController.h"
#import "SportsViewController.h"
#import "ScienceViewController.h"
#import "FinanceViewController.h"
#import "SearchViewController.h"
@interface NewsViewController ()



@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻";
    
    HeaderViewController *headerVC = [[HeaderViewController alloc] init];
    headerVC.title = @"首页";
    
    EntertainmentViewController *entertainmentVC = [[EntertainmentViewController alloc] init];
    entertainmentVC.title = @"娱乐";
    
    SportsViewController *sportsVC = [[SportsViewController alloc] init];
    sportsVC.title = @"体育";
    
    ScienceViewController *scienceVC = [[ScienceViewController alloc] init];
    scienceVC.title = @"科技";
    
    FinanceViewController *financeVC = [[FinanceViewController alloc] init];
    financeVC.title = @"财经";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[headerVC, entertainmentVC,sportsVC,scienceVC,financeVC];
    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
#pragma mark - 搜索
-(void)searchItemAction:(UIBarButtonItem *)sender
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    UINavigationController *searchNC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:searchNC animated:YES completion:nil];
}
-(void)backAction:(UITabBarItem *)sender
{
    
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
