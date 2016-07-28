//
//  DataTool.m
//  WangYi
//

//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "DataTool.h"

@implementation DataTool


+(void)getNewsDataWithUrlString:(NSString *)urlString withHTTPMethod:(NSString *)method withHTTPBody:(NSString *)body withBackBlock:(PassValueBackBlock)block
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    if ([method isEqualToString:@"POST"]) {
        [request setHTTPMethod:method];
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            block(object);
        }else{
            NSLog(@"%@",error);
        }
    }];
    [dataTask resume];
}

@end
