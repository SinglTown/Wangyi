//
//  DetailPictureViewController.m
//  News
//
//  Created by lanou3g on 15/12/23.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "DetailPictureViewController.h"
#import "PictureView.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface DetailPictureViewController ()
@property (nonatomic,strong)PictureView *pictureView;
@property (nonatomic,strong)UIImageView *myImageView;
@end

@implementation DetailPictureViewController
-(void)loadView
{
    self.pictureView = [[PictureView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.pictureView.backgroundColor = [UIColor blackColor];
    self.view = self.pictureView;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self layoutDetaiPicture];
    
    
}
-(void)layoutDetaiPicture
{
    self.pictureView.scrollView.contentSize = CGSizeMake(kScreenWidth*self.picArray.count, 500);
    self.pictureView.scrollView.pagingEnabled = YES;
    for (int i=0; i<self.picArray.count; i++) {
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 200-64, kScreenWidth, 200)];
        self.myImageView.backgroundColor = [UIColor redColor];
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[i]]];
        [self.pictureView.scrollView addSubview:self.myImageView];
    }
    
    self.pictureView.titleLabel.text = self.imageTitle;
    
    self.pictureView.textView.text = self.desc;
    self.pictureView.textView.font = [UIFont systemFontOfSize:15];
    
    self.pictureView.countOfImageLabel.text = self.countOfImage;
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
