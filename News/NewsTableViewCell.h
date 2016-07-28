//
//  NewsTableViewCell.h
//  WangYi
//
//  Created by lanou3g on 15/12/17.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
//图片
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//时间
@property (strong, nonatomic) IBOutlet UILabel *ptimeLabel;
//跟帖量
@property (strong, nonatomic) IBOutlet UILabel *replyCount;


//赋值
-(void)setValueForCellWith:(NewsModel *)model;

@end
