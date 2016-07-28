//
//  CoreDataHandle.h
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsModel;
@class MovieModel;
@interface CoreDataHandle : NSObject

+(instancetype)sharedCoreDataHandle;

#pragma mark - 新闻插入数据
-(void)insertNewsDataWithModel:(NewsModel *)model;
#pragma mark - 视频插入数据
-(void)insertMovieDataWithModel:(MovieModel *)model;
#pragma mark - 注册用户信息插入数据
-(void)insertUserInforDataWithName:(NSString *)name
                      withPassWord:(NSString *)passWord
                        withNumber:(NSString *)number
                          withMail:(NSString *)mail;
#pragma mark - 浏览记录插入数据
-(void)insertHistoryInforDataWithModel:(NewsModel *)model;
#pragma mark - 查找所有数据
-(NSArray *)searchAllNewsDataWithString:(NSString *)string;
#pragma mark - 删除所有
-(void)deleteAllNewsDataWithString:(NSString *)string;
@end
