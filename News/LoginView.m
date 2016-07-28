//
//  LoginView.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}
-(void)allViews
{
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.myImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 50);
    self.myImageView.clipsToBounds = YES;
    self.myImageView.layer.cornerRadius = 40;
    self.myImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.myImageView];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame = CGRectMake(0, 0, 80, 40);
    self.loginButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 120);
    [self.loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
//    self.loginButton.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.loginButton];
}
@end
