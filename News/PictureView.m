//
//  PictureView.m
//  News
//
//  Created by lanou3g on 15/12/23.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "PictureView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation PictureView

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.scrollView.backgroundColor = [UIColor orangeColor];
//    self.scrollView.contentSize = CGSizeMake(1000, 200);
    [self addSubview:self.scrollView];
    
   
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 450, kScreenWidth-80, 30)];
    self.titleLabel.textColor = [UIColor whiteColor];
//    self.titleLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.titleLabel];
    
    self.countOfImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-60, 450, 50, 30)];
    self.countOfImageLabel.textColor = [UIColor whiteColor];
//    self.countOfImageLabel.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.countOfImageLabel];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 490, kScreenWidth-20, 140)];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.editable = NO;
    self.textView.textColor = [UIColor whiteColor];
    self.textView.allowsEditingTextAttributes = NO;
    [self addSubview:self.textView];
    
}
@end
