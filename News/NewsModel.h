//
//  NewsModel.h
//  WangYi
//
//  Created by lanou3g on 15/12/18.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

//新闻图片
@property (nonatomic,copy)NSString *imgsrc;
//新闻标题
@property (nonatomic,copy)NSString *title;
//时间
@property (nonatomic,copy)NSString *ptime;
//跟帖
@property (nonatomic,copy)NSString *replyCount;
//详情界面的拼接字符串
@property (nonatomic,copy)NSString *docid;
//多张图片
@property (nonatomic,strong)NSArray *imgextra;
//轮播图
@property (nonatomic,strong)NSArray *ads;
//详情界面的URL
@property (nonatomic,copy)NSString *url;


@end
