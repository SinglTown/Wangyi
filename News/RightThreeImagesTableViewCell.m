//
//  RightThreeImagesTableViewCell.m
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "RightThreeImagesTableViewCell.h"
#import "PictureModel.h"
#import "UIImageView+WebCache.h"
@implementation RightThreeImagesTableViewCell

-(void)setCellValueWithModel:(PictureModel *)model
{
    self.setnameLabel.text = model.setname;
    [self.clientCover1ImageView sd_setImageWithURL:[NSURL URLWithString:model.clientcover1]];
    if (model.pics.count > 2) {
        NSString *firstImage = model.pics[1];
        NSString *secondImage = model.pics[2];
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:firstImage]];
        [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:secondImage]];
    }else if(model.pics.count>0){
        NSString *firstImage = model.pics[0];
        NSString *secondImage = model.pics[1];
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:firstImage]];
        [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:secondImage]];
    }
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
