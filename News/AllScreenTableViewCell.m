//
//  AllScreenTableViewCell.m
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "AllScreenTableViewCell.h"
#import "PictureModel.h"
#import "UIImageView+WebCache.h"
@implementation AllScreenTableViewCell


-(void)setCellValueWithModel:(PictureModel *)model
{
    self.titleLabel.text = model.setname;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.clientcover1]];
    self.countOfImageLabel.text = model.imgsum;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",model.replynum];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
