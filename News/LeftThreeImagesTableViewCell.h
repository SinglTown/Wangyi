//
//  LeftThreeImagesTableViewCell.h
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureModel;
@interface LeftThreeImagesTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *setNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UIImageView *firstImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;
@property (strong, nonatomic) IBOutlet UILabel *countOfImageLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyCountLabel;


-(void)setCellValueWithModel:(PictureModel *)model;
@end
