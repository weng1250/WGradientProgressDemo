//
//  ViewController.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "ViewController.h"
#import "WGradientProgress.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    [gradProg showOnParent:self.navigationController.navigationBar position:WProgressPosDown];
    
    //here we simulate change of progress
    [self simulateProgress];
    
    //add switch
    UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [swi addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventTouchUpInside];
    swi.center = self.view.center;
    [swi setOn:YES];
    [self.view addSubview:swi];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}

- (void)simulateProgress
{
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [gradProg progress] + increment;
        NSLog(@"progress:%@", @([gradProg progress]));
        [gradProg setProgress:progress];
        if (progress < 1.0) {
            
            [self simulateProgress];
        }
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchSwitch:(UISwitch *)swi
{
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    if (swi.isOn) {
        [gradProg showOnParent:self.view position:WProgressPosDown];
        [self simulateProgress];
    } else {
        [gradProg hide];
    }
}

@end
