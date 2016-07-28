//
//  MovieTableViewCell.m
//  WangYi
//
//  Created by lanou3g on 15/12/19.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "MovieModel.h"
@implementation MovieTableViewCell


//赋值
-(void)setValueForCellWithModel:(MovieModel *)model
{
    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.descriptions;
    
    NSString *lengthString = [NSString stringWithFormat:@"%ld:%ld",[model.length integerValue]/60,[model.length integerValue]%60];
    self.lengthLabel.text = lengthString;
    self.playCountLabel.text = model.playCount;
    
    
    dispatch_queue_t queue = dispatch_queue_create("hehe", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.mp4_url]];
        self.movieWebView.scrollView.bounces = NO;
        self.movieWebView.delegate = self;
//        self.movieWebView.allowsInlineMediaPlayback = YES;
 //       self.movieWebView.mediaPlaybackRequiresUserAction = YES;
        [self.movieWebView loadRequest:request];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });


    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    navigationType = UIWebViewNavigationTypeBackForward;
    return YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
