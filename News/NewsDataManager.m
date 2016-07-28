//
//  NewsDataManager.m
//  WangYi
//
//  Created by lanou3g on 15/12/18.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "NewsDataManager.h"
#import "DataTool.h"
#import "NewsModel.h"
#import "MovieModel.h"
#import "PictureModel.h"
static NewsDataManager *manager = nil;
@implementation NewsDataManager

+(instancetype)sharedNewsDataManager
{
    return [[self alloc] init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    return manager;
}
#pragma mark - 要闻界面
-(void)getNewsDatawithBlock:(HeaderBackReloadDataBlock)block
{
    NSString *urlString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html";
    [DataTool getNewsDataWithUrlString:urlString withHTTPMethod:nil withHTTPBody:nil withBackBlock:^(id object) {
        NSDictionary *dic = object;
        NSArray *array = [dic valueForKey:@"T1348647853363"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *d in array) {
            NewsModel *model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:d];
            model.replyCount = [[d valueForKey:@"replyCount"] stringValue];
            [arr addObject:model];
        }
        self.headerNewsDataArray = [NSArray arrayWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }];
}
#pragma mark - 其它新闻界面
-(void)getDataWithUrlString:(NSString *)urlString
                  withblock:(OtherBackReloadDataBlock)block
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@.html",urlString];
    NSString *key = [urlString substringToIndex:14];
    [DataTool getNewsDataWithUrlString:url withHTTPMethod:nil withHTTPBody:nil withBackBlock:^(id object) {
        @autoreleasepool {
            NSDictionary *dic = object;
            NSArray *array = [dic valueForKey:key];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *d in array) {
                NewsModel *model = [[NewsModel alloc] init];
                [model setValuesForKeysWithDictionary:d];
                model.replyCount = [[d valueForKey:@"replyCount"] stringValue];
                [arr addObject:model];
            }
            if ([urlString isEqualToString:@"T1348648517839/0-50"]) {
                self.entertainNewsDataArray = [NSArray arrayWithArray:arr];
            }else if ([urlString isEqualToString:@"T1348649079062/0-40"]){
                self.sportsNewsDataArray = [NSArray arrayWithArray:arr];
            }else if ([urlString isEqualToString:@"T1348649580692/0-40"]){
                self.scienceNewsDataArray = [NSArray arrayWithArray:arr];
            }else if ([urlString isEqualToString:@"T1348648756099/0-20"]){
                self.financeNewsDataArray = [NSArray arrayWithArray:arr];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    }];
}
#pragma mark - 视频
-(void)GetMovieDateWithString:(NSString *)string withBlock:(BackMovieReloadBlock)block
{
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/list/%@/n/0-10.html",string];
    [DataTool getNewsDataWithUrlString:urlString withHTTPMethod:nil withHTTPBody:nil withBackBlock:^(id object) {
        @autoreleasepool {
            NSDictionary *dic = object;
            NSArray *array = [dic valueForKey:string];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *d in array) {
                MovieModel *model = [[MovieModel alloc] init];
                [model setValuesForKeysWithDictionary:d];
                model.playCount = [[d valueForKey:@"playCount"] stringValue];
                model.length = [[d valueForKey:@"length"] stringValue];
                [arr addObject:model];
            }
            self.movieArray = [NSArray arrayWithArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
            NSLog(@"-------%@",self.movieArray);
        }
    }];
}
#pragma mark - 图片
-(void)getPictureDataWithBlock:(BackPictureReloadBlock)block
{
    NSString *urlString = @"http://c.m.163.com/photo/api/list/0096/54GI0096.json";
    [DataTool getNewsDataWithUrlString:urlString withHTTPMethod:nil withHTTPBody:nil withBackBlock:^(id object) {
        NSArray *array = object;
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            PictureModel *model = [[PictureModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [dataArray addObject:model];
        }
        self.pictureArray = [NSArray arrayWithArray:dataArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
        NSLog(@"--------%@",self.pictureArray);
    }];
}
@end
