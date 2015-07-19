//
//  WGradientProgress.h
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WProgressPos)
{
    WProgressPosUp = 0,     //progress is on the up border of parent view
    WProgressPosDown        //progress is on the down border of parent view
};

@interface WGradientProgress : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) WProgressPos position;

+ (WGradientProgress *)sharedInstance;

/**
 *  the main interface to show WGradientProgress obj
 *
 *  @param parentView which view to be attach
 *  @param pos        up or down
 */
- (void)showOnParent:(UIView *)parentView position:(WProgressPos)pos;

/**
 *  the main interface to hide WGradientProgress obj
 */
- (void)hide;

@end
