//
//  DataTool.h
//  WangYi
//
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PassValueBackBlock)(id object);

@interface DataTool : NSObject

+(void)getNewsDataWithUrlString:(NSString *)urlString
                 withHTTPMethod:(NSString *)method
                   withHTTPBody:(NSString *)body
                  withBackBlock:(PassValueBackBlock)block;


@end
