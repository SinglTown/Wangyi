//
//  MovieModel.m
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descriptions = value;
    }
}

@end
