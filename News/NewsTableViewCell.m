//
//  NewsTableViewCell.m
//  WangYi
//
//  Created by lanou3g on 15/12/17.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
@implementation NewsTableViewCell

//赋值
-(void)setValueForCellWith:(NewsModel *)model
{
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.titleLabel.text = model.title;
    NSString *str = [model.ptime substringToIndex:10];
    self.ptimeLabel.text = str;
    if (model.replyCount != nil) {
        self.replyCount.text = [NSString stringWithFormat:@"%@跟帖",model.replyCount];
    }
}

- (void)awakeFromNib {
    self.newsImageView.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
