//
//  PictureModel.h
//  News
//
//  Created by lanou3g on 15/12/23.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject


//主页单张图片
@property (nonatomic,copy)NSString *clientcover1;
//主页三张图的大图
@property (nonatomic,copy)NSString *clientcover;
//主页setname
@property (nonatomic,copy)NSString *setname;
//详情轮播图下方的文字
@property (nonatomic,copy)NSString *desc;
//轮播图的数量
@property (nonatomic,copy)NSString *imgsum;
//跟帖数量
@property (nonatomic,copy)NSString *replynum;
//轮播图集
@property (nonatomic,strong)NSArray *pics;

@end
