//
//  ImagesScrollView.m
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "ImagesScrollView.h"
#import "NewsModel.h"
#import "NewsDataManager.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ImagesScrollView

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
    self.model = [[NewsDataManager sharedNewsDataManager].headerNewsDataArray firstObject];
    self.imageUrlArray = [NSMutableArray array];
    for (NSDictionary *d in self.model.ads) {
        [self.imageUrlArray addObject:[d valueForKey:@"imgsrc"]];
    }
    if (self.imageUrlArray.count >0) {
        self.imageCount = self.imageUrlArray.count;
        
        NSLog(@"===---======-----%ld",self.imageCount);
        
        [self addScrollView];
        
        [self addImageViews];
        
        //设置默认图片
        [self setDefaultImage];
        
        [self addPageControl];
        
    }
}
-(void)addScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    [self addSubview:self.scrollView];
    
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*self.imageCount, 180);
    //设置当前显示位置为中间图片
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
        
}
-(void)addImageViews
{
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    [self.scrollView addSubview:self.leftImageView];
    self.centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 180)];
    [self.scrollView addSubview:self.centerImageView];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, 180)];
    [self.scrollView addSubview:self.rightImageView];
}
-(void)setDefaultImage
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[self.imageCount-1]] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[0]] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[1]] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    //设置当前页
    self.pageControl.currentPage = self.currentImageIndex;
}
-(void)addPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.pageControl.center = CGPointMake(kScreenWidth/2, 180-10);
    self.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.numberOfPages = self.imageCount;
    
    [self addSubview:self.pageControl];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    
    self.pageControl.currentPage = self.currentImageIndex;
    
}
-(void)reloadImage
{
    NSInteger leftImageIndex,rightImageIndex;
    
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x>kScreenWidth) {//向右滑动
        self.currentImageIndex = (self.currentImageIndex +1)%self.imageCount;
    }else if (offset.x<kScreenWidth){//向左滑动
        self.currentImageIndex = (self.currentImageIndex +self.imageCount-1)%self.imageCount;
    }
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[self.currentImageIndex]] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    //重新设置左右图片
    leftImageIndex = (self.currentImageIndex +self.imageCount-1)%self.imageCount;
    rightImageIndex = (self.currentImageIndex +1)%self.imageCount;
    //重新设置左右图片
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[leftImageIndex]] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[rightImageIndex]] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
}


@end
