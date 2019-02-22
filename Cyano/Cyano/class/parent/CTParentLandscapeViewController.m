//
//  CTParentLandscapeViewController.m
//  iQBTeacher
//
//  Created by Yuanhai on 23/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTParentLandscapeViewController.h"

@interface CTParentLandscapeViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CTParentLandscapeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // 主视图，解决旋转问题，添加的view不需要计算了
    float heightMove = [UIApplication sharedApplication].statusBarFrame.size.height - NavigationStatusBarHeight;
    float mainWidth = self.view.width;
    float mainHeight = self.view.height + heightMove;
    self.mainView = [[UIView alloc] init];
    self.mainView.frame = CGRectMake((mainWidth - mainHeight) / 2, (mainHeight - mainWidth) / 2, mainHeight, mainWidth);
    [self.view addSubview:self.mainView];
    
    // 基础视图宽高
    self.width = self.mainView.width;
    self.height = self.mainView.height;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.mainView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    // 不自动锁屏
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // 检查旋转
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 自动锁屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    // 停止检查旋转
    [self stopTimer];
}

// (继承)界面转向左
- (void)viewChangeToLeft
{
}

// (继承)界面转向右
- (void)viewChangeToRight
{
}

#pragma mark - override

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateOrientations) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if(self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

// 判断ios屏幕方向放置状态
- (void)updateOrientations
{
    UIDevice *device = [UIDevice currentDevice];
    float rotation = 0;
    switch (device.orientation)
    {
        case UIDeviceOrientationLandscapeLeft:
            rotation = M_PI_2;
            [self viewChangeToLeft];
            break;
        case UIDeviceOrientationLandscapeRight:
            rotation = M_PI_2 * 3;
            [self viewChangeToRight];
            break;
        default:
            break;
    }
    
    if (rotation != 0 && !CGAffineTransformEqualToTransform(self.mainView.transform, CGAffineTransformMakeRotation(rotation)))
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.mainView.transform = CGAffineTransformMakeRotation(rotation);
        }];
    }
}

@end
