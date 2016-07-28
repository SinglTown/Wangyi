//
//  DetailPictureViewController.h
//  News
//
//  Created by lanou3g on 15/12/23.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPictureViewController : UIViewController


//图片张数
@property (nonatomic,copy)NSString *countOfImage;

@property (nonatomic,copy)NSString *imageTitle;

@property (nonatomic,copy)NSString *desc;

@property (nonatomic,strong)NSArray *picArray;

@end
