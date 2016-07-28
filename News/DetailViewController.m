//
//  DetailViewController.m
//  News
//
//  Created by lanou3g on 15/12/21.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "DetailViewController.h"
#import "UIView+HB.h"
#import <ShareSDK/ShareSDK.h>
@interface DetailViewController ()
{
    BOOL _isCanShare;
}
@property (nonatomic,strong)UIView *shareView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //加载网页
    [self loadWebView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-liebiao.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    _isCanShare = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-48, -36, 35, 80)];
    self.shareView.backgroundColor = [UIColor redColor];
    self.shareView.clipsToBounds = YES;
    self.shareView.layer.cornerRadius = 5;
    [self.view addSubview:self.shareView];
    
    UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeSystem];
    qqButton.frame = CGRectMake(5, 10, 25, 25);
    [qqButton addTarget:self action:@selector(ShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [qqButton setBackgroundImage:[UIImage imageNamed:@"iconfont-qqkongjian.png"] forState:UIControlStateNormal];
    [self.shareView addSubview:qqButton];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    collectButton.frame = CGRectMake(5, 40, 25, 25);
    [collectButton setBackgroundImage:[UIImage imageNamed:@"iconfont-shoucang.png"] forState:UIControlStateNormal];
    [self.shareView addSubview:collectButton];


}
-(void)ShareAction:(UIButton *)sender
{
//    //创建分享参数
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:@"分享内容 @value(url)"
//                                     images:@[[UIImage imageNamed:@"shareImg"]]
//                                        url:[NSURL URLWithString:@"http://mob.com"]
//                                      title:@"分享标题"
//                                       type:SSDKContentTypeImage];
//    
//    //进行分享
//    [ShareSDK share:SSDKPlatformTypeSinaWeibo
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         
//         switch (state) {
//             case SSDKResponseStateSuccess:
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             case SSDKResponseStateFail:
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                     message:[NSString stringWithFormat:@"%@", error]
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             case SSDKResponseStateCancel:
//             {
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             default:
//                 break;
//         }
//         
//     }];
}
#pragma mark - 分享
-(void)rightItemAction:(UIBarButtonItem *)sender
{
    if (_isCanShare == NO) {
        [UIView animateWithDuration:.5 animations:^{
            self.shareView.y = 64;
            _isCanShare = YES;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            self.shareView.y = -36;
            _isCanShare = NO;
        } completion:^(BOOL finished) {
            
        }];
    }
//    [UIView animateWithDuration:.5 animations:^{
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 64, 40, 80)];
//        view.backgroundColor = [UIColor purpleColor];
//        [self.view addSubview:view];
//        self.shareView.y = 64;
//        _isCanShare = YES;
//    } completion:^(BOOL finished) {
//        
//        _isCanShare = NO;
//    }];
}
#pragma mark - 加载webView
-(void)loadWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [webView loadRequest:request];

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
