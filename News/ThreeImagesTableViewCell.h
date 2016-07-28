//
//  ThreeImagesTableViewCell.h
//  WangYi
//
//  Created by lanou3g on 15/12/18.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface ThreeImagesTableViewCell : UITableViewCell

//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//第一张图片
@property (strong, nonatomic) IBOutlet UIImageView *firstImageView;

//第二张图片
@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;

//第三张图片
@property (strong, nonatomic) IBOutlet UIImageView *threeImageview;

//赋值
-(void)getDataForCellWithModel:(NewsModel *)model;

@end
