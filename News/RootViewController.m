//
//  RootViewController.m
//  News
//
//  Created by lanou3g on 15/12/20.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "RootViewController.h"
#import "NewsViewController.h"
#import "MovieViewController.h"
#import "MyViewController.h"
#import "PictureViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:newsVC];
    nav1.navigationBar.barTintColor = [UIColor redColor];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"iconfont-xinwen.png"] tag:100];
    
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:movieVC];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视听" image:[UIImage imageNamed:@"iconfont-shipin1.png"] tag:101];
    
    PictureViewController *pictureVC = [[PictureViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:pictureVC];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"图库" image:[UIImage imageNamed:@"iconfont-gallery_line.png"] tag:102];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:myVC];
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage imageNamed:@"iconfont-center.png"] tag:103];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4];
    
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
