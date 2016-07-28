//
//  MovieModel.h
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

//图片
@property (nonatomic,copy)NSString *cover;
//标题
@property (nonatomic,copy)NSString *title;
//描述
@property (nonatomic,copy)NSString *descriptions;
//播放量
@property (nonatomic,copy)NSString *playCount;
//时长
@property (nonatomic,copy)NSString *length;
//视频连接
@property (nonatomic,copy)NSString *mp4_url;

@end
