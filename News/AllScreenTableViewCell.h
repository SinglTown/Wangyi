//
//  AllScreenTableViewCell.h
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureModel;
@interface AllScreenTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;

@property (strong, nonatomic) IBOutlet UILabel *countOfImageLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyCountLabel;

-(void)setCellValueWithModel:(PictureModel *)model;

@end
