//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"
#import "UIView+Frame.h"
#import "GlobalCommon.h"

@interface WGradientProgress ()

@property (nonatomic, strong) CAGradientLayer *gradLayer;

@property (nonatomic, strong) CALayer *mask;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIView *parentView;

@end

@implementation WGradientProgress


#pragma mark -- public methods

+ (WGradientProgress *)sharedInstance
{
    static WGradientProgress *s_instance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_instance == nil) {
            s_instance = [[WGradientProgress alloc] init];
            s_instance.progress = 0;
            s_instance.position = WProgressPosDown;
            [s_instance setupTimer];
            s_instance.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
    });
    return s_instance;
}

/**
 *  the main interface to show WGradientProgress obj, position is WProgressPosDown by default.
 *
 *  @param parentView which view to be attach
 */
- (void)showOnParent:(UIView *)parentView
{
    [self showOnParent:parentView position:WProgressPosDown];
}

/**
 *  the main interface to show WGradientProgress obj
 *
 *  @param parentView which view to be attach
 *  @param pos        up or down
 */
- (void)showOnParent:(UIView *)parentView position:(WProgressPos)pos
{
    self.position = pos;
    self.parentView = parentView;
    CGRect frame = [self decideTargetFrame:parentView];
    self.frame = frame;
    [parentView addSubview:self];
    [self initBottomLayer];
    [self startTimer];
}

/**
 *  the main interface to hide WGradientProgress obj
 */
- (void)hide
{
    [self pauseTimer];
    if ([self superview]) {
        [self removeFromSuperview];
    }
    self.parentView = nil;
}

#pragma mark -- setter / getter
- (void)setProgress:(CGFloat)progress
{
    if (progress < 0) {
        progress = 0;
    }
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    CGFloat maskWidth = progress * self.width;
    self.mask.frame = CGRectMake(0, 0, maskWidth, self.height);
}


#pragma mark -- private methods

- (CGRect)decideTargetFrame:(UIView *)parentView
{
    CGRect frame = CGRectZero;
    //progress is on the down border of parentView
    if (self.position == WProgressPosDown) {
        frame = CGRectMake(0, parentView.height, parentView.width, 2);
    } else if (self.position == WProgressPosUp) {
        frame = CGRectMake(0, -1, parentView.width, 1);
    }
    return frame;
}

- (void)initBottomLayer
{
    if (self.gradLayer == nil) {
        self.gradLayer = [CAGradientLayer layer];
        self.gradLayer.frame = self.bounds;
    }
    self.gradLayer.startPoint = CGPointMake(0, 0.5);
    self.gradLayer.endPoint = CGPointMake(1, 0.5);
    
    //create colors, important section
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger deg = 0; deg <= 360; deg += 5) {
        
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * deg / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    [self.gradLayer setColors:[NSArray arrayWithArray:colors]];
    self.mask = [CALayer layer];
    [self.mask setFrame:CGRectMake(self.gradLayer.frame.origin.x, self.gradLayer.frame.origin.y,
                                   self.progress * self.width, self.height)];
    self.mask.borderColor = [[UIColor blueColor] CGColor];
    self.mask.borderWidth = 2;
    [self.gradLayer setMask:self.mask];
    [self.layer addSublayer:self.gradLayer];
}

/**
 *  here I use timer to circularly move colors
 */
- (void)setupTimer
{
    CGFloat interval = 0.03;
    if (self.timer == nil) {
         self.timer = [NSTimer timerWithTimeInterval:interval target:self
                                            selector:@selector(timerFunc)
                                            userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}


- (void)startTimer
{
    //start timer
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer setFireDate:[NSDate date]];
}

/**
 *  here we just pause timer, rather than stopping forever.
 *  NOTE: [timer invalidate] is not fit here.
 */
- (void)pauseTimer
{
    [self.timer setFireDate:[NSDate distantFuture]];
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
    [self.gradLayer setColors:copyArray];
}

@end
