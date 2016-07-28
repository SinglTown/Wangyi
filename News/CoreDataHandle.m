//
//  CoreDataHandle.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "CoreDataHandle.h"
#import <CoreData/CoreData.h>
#import "News.h"
#import "Movie.h"
#import "NewsModel.h"
#import "MovieModel.h"
#import "User.h"
#import "History.h"
static CoreDataHandle *handle = nil;
@interface CoreDataHandle ()

@property (nonatomic,strong)NSManagedObjectContext *context;



@end
@implementation CoreDataHandle

+(instancetype)sharedCoreDataHandle
{
    return [[self alloc] init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (handle == nil) {
            handle = [super allocWithZone:zone];
            [handle createCoreData];
        }
    });
    return handle;
}
#pragma mark - 构建CoreData
-(void)createCoreData
{
    //1.创建一个NSManagedObjectModel对象(描述实体)
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //2.桥梁(连接器)
    NSPersistentStoreCoordinator *storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //存储的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"data"];
    //连接路径
    //第一参数:存储的类型
    //第三个参数:路径
    //第四个参数:options-->版本迁移必须填写
    NSError *error = nil;
    NSDictionary *dict = @{NSMigratePersistentStoresAutomaticallyOption:[NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption:[NSNumber numberWithBool:YES]};
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:dict error:&error];
    
    //3.初始化上下文
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //上下文管理 连接器
    self.context.persistentStoreCoordinator = storeCoordinator;
    NSLog(@"******%@",path);
}
#pragma mark - 新闻插入数据
-(void)insertNewsDataWithModel:(NewsModel *)model
{
    News *news = [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:self.context];
    //通过KVC赋值
    news.title = model.title;
    news.url = model.url;
    if ([self.context hasChanges]) {
        [self.context save:nil];
    }
}
#pragma mark - 视频插入数据
-(void)insertMovieDataWithModel:(MovieModel *)model
{
    Movie *movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:self.context];
    movie.title = model.title;
    movie.mp4_url = model.mp4_url;
    if ([self.context hasChanges]) {
        [self.context save:nil];
    }
}
#pragma mark - 注册用户信息插入数据
-(void)insertUserInforDataWithName:(NSString *)name
                      withPassWord:(NSString *)passWord
                        withNumber:(NSString *)number
                          withMail:(NSString *)mail
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    user.name = name;
    user.pass_word = passWord;
    user.telphone_number = number;
    user.mail = mail;
    if ([self.context hasChanges]) {
        [self.context save:nil];
    }
}
#pragma mark - 浏览记录插入数据
-(void)insertHistoryInforDataWithModel:(NewsModel *)model
{
    History *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:self.context];
    history.title = model.title;
    history.url = model.url;
    history.image = [[model.imgextra firstObject] valueForKey:@"imgsrc"];
    if ([self.context hasChanges]) {
        [self.context save:nil];
    }
}
#pragma mark - 查找所有数据
-(NSArray *)searchAllNewsDataWithString:(NSString *)string
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:string];
    NSArray *objectArray = [self.context executeFetchRequest:request error:nil];
    return objectArray;
}
#pragma mark - 删除所有
-(void)deleteAllNewsDataWithString:(NSString *)string
{
    NSArray *allDataArray = [self searchAllNewsDataWithString:string];
    for (News *news in allDataArray) {
        [self.context deleteObject:news];
    }
}
@end
