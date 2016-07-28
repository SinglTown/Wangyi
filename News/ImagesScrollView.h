//
//  ImagesScrollView.h
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface ImagesScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIImageView *leftImageView;

@property (nonatomic,strong)UIImageView *centerImageView;

@property (nonatomic,strong)UIImageView *rightImageView;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,assign)NSInteger currentImageIndex;

@property (nonatomic,assign)NSInteger imageCount;

@property (nonatomic,strong)NSMutableArray *imageUrlArray;

@property (nonatomic,strong)NewsModel *model;

-(void)reloadImage;

@end
