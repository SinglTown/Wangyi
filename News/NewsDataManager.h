//
//  NewsDataManager.h
//  WangYi
//
//  Created by lanou3g on 15/12/18.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HeaderBackReloadDataBlock)();

typedef void(^OtherBackReloadDataBlock)();

typedef void(^BackMovieReloadBlock)();

typedef void(^BackPictureReloadBlock)();

@interface NewsDataManager : NSObject


//首页
@property (nonatomic,strong)NSArray *headerNewsDataArray;
//娱乐
@property (nonatomic,strong)NSArray *entertainNewsDataArray;
//体育
@property (nonatomic,strong)NSArray *sportsNewsDataArray;
//科技
@property (nonatomic,strong)NSArray *scienceNewsDataArray;
//财经
@property (nonatomic,strong)NSArray *financeNewsDataArray;

//视频
@property (nonatomic,strong)NSArray *movieArray;
//图片
@property (nonatomic,strong)NSArray *pictureArray;

+(instancetype)sharedNewsDataManager;

#pragma mark - 要闻界面
-(void)getNewsDatawithBlock:(HeaderBackReloadDataBlock)block;

#pragma mark - 其它新闻界面
-(void)getDataWithUrlString:(NSString *)urlString
                  withblock:(OtherBackReloadDataBlock)block;

#pragma mark - 视频
-(void)GetMovieDateWithString:(NSString *)string
                       withBlock:(BackMovieReloadBlock)block;

#pragma mark - 图片
-(void)getPictureDataWithBlock:(BackPictureReloadBlock)block;
@end
