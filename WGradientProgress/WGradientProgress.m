//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"

@implementation WGradientProgress

+ (WGradientProgress *)sharedInstance
{
    static WGradientProgress *s_instance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_instance == nil) {
            s_instance = [[WGradientProgress alloc] init];
            s_instance.progress = 0;
            s_instance.position = WProgressPosDown;
        }
    });
    return s_instance;
}

- (void)showOnParent:(UIView *)parentView position:(WProgressPos)pos
{
    self.position = pos;
}


#pragma mark -- private methods
- (CGRect)decideTargetFrame:(UIView *)parentView
{
    CGRect frame = CGRectZero;
    //progress is on the down border of parentView
    if (self.position == WProgressPosDown) {
        
    }
}


@end
