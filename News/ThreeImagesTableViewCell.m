//
//  ThreeImagesTableViewCell.m
//  WangYi
//
//  Created by lanou3g on 15/12/18.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "ThreeImagesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NewsModel.h"
@implementation ThreeImagesTableViewCell

//赋值
-(void)getDataForCellWithModel:(NewsModel *)model
{
    self.titleLabel.text = model.title;
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    NSArray *array = model.imgextra;
    NSString *imageString1 = [[array firstObject] valueForKey:@"imgsrc"];
    NSString *imageString2 = [[array lastObject] valueForKey:@"imgsrc"];
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:imageString1] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
    [self.threeImageview sd_setImageWithURL:[NSURL URLWithString:imageString2] placeholderImage:[UIImage imageNamed:@"2007119122519868_2.jpg"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
