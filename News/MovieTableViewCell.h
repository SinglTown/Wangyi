//
//  MovieTableViewCell.h
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieModel;
@interface MovieTableViewCell : UITableViewCell<UIWebViewDelegate>
//标题
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//描述
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
//时长
@property (strong, nonatomic) IBOutlet UILabel *lengthLabel;
//播放量
@property (strong, nonatomic) IBOutlet UILabel *playCountLabel;
//播放视频的webView
@property (strong, nonatomic) IBOutlet UIWebView *movieWebView;


//赋值
-(void)setValueForCellWithModel:(MovieModel *)model;

@end
