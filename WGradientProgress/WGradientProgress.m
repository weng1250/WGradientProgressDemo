//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"
#import "UIView+Frame.h"

@interface WGradientProgress ()

@property (nonatomic, strong) CAGradientLayer *gradLayer;

@property (nonatomic, strong) CALayer *mask;

@property (nonatomic, strong) NSTimer *timer;

@end

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
    CGRect frame = [self decideTargetFrame:parentView];
    self.frame = frame;
    [parentView addSubview:self];
    [self initBottomLayer];
    //setup timer
    [self setupTimer];
}

- (void)hide
{
    [self.timer invalidate];
    if ([self superview]) {
        [self removeFromSuperview];
    }
}

#pragma mark -- setter / getter
- (void)setProgress:(CGFloat)progress
{
    if (progress < 0 || progress > 1) {
        return;
    }
    CGFloat maskWidth = progress * self.width;
    self.mask.frame = CGRectMake(0, 0, maskWidth, self.height);
}


#pragma mark -- private methods
- (CGRect)decideTargetFrame:(UIView *)parentView
{
    CGRect frame = CGRectZero;
    //progress is on the down border of parentView
    if (self.position == WProgressPosDown) {
        frame = CGRectMake(0, parentView.bottom - 10, parentView.width, 100);
    } else if (self.position == WProgressPosUp) {
        frame = CGRectMake(0, -1, parentView.width, 1);
    }
    return frame;
}

- (void)initBottomLayer
{
    //get gradient layer
    if (self.gradLayer == nil) {
        self.gradLayer = [CAGradientLayer layer];
        self.gradLayer.frame = self.frame;
        self.gradLayer.backgroundColor = [[UIColor redColor] CGColor];
    }
    self.gradLayer.startPoint = CGPointMake(0, 0.5);
    self.gradLayer.endPoint = CGPointMake(1, 0.5);
    
    //create colors, important section
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger bluePixel = 0; bluePixel < 255; bluePixel++) {
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:bluePixel alpha:1];
        [colors addObject:color];
    }
    [self.gradLayer setColors:colors];
    self.mask = [CALayer layer];
    [self.mask setFrame:CGRectMake(0, 0, self.progress * self.width, self.height)];
    //[self.gradLayer setMask:self.mask];
    [self.layer addSublayer:self.gradLayer];
}

/**
 *  here I use timer to circularly move colors
 */
- (void)setupTimer
{
    CGFloat interval = 0.5;
    if (self.timer == nil) {
         self.timer = [NSTimer timerWithTimeInterval:interval target:self
                                            selector:@selector(timerFunc)
                                            userInfo:nil repeats:YES];
    }
    if ([self.timer isValid] == NO) {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}


/**
 *  rearrange color array
 */
- (void)timerFunc
{
    CAGradientLayer *gradLayer = self.gradLayer;
    NSMutableArray *copyArray = [NSMutableArray arrayWithArray:[gradLayer colors]];
    UIColor *lastColor = [copyArray lastObject];
    [copyArray removeLastObject];
    if (lastColor) {
        [copyArray insertObject:lastColor atIndex:0];
    }
    
    //move color with animation
    // Create an animation to slowly move the hue gradient left to right.
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setFromValue:[gradLayer colors]];
    [animation setToValue:copyArray];
    [animation setDuration:0.08];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDelegate:self];
    
    // Add the animation to our layer
    [gradLayer addAnimation:animation forKey:@"animateGradient"];
}


@end
