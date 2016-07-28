//
//  LineView.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "LineView.h"

@implementation LineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);//线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);//线的颜色
    CGContextBeginPath(context);
    
    //第一条线
    CGContextMoveToPoint(context, 50, 150);//起点坐标
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-50, 150);//终点坐标
    CGContextStrokePath(context);
    //第二条线
    CGContextMoveToPoint(context, 50, 200);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-50, 200);
    CGContextStrokePath(context);
    //第三条线
    CGContextMoveToPoint(context, 50, 400);//起点坐标
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-50, 400);//终点坐标
    CGContextStrokePath(context);
//    //第四条线
//    CGContextMoveToPoint(context, 250, 400);//起点坐标
//    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width-50, 400);//终点坐标
//    CGContextStrokePath(context);
}


@end
