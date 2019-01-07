//
//  CTAppNavViewController.m
//  iQBTeacher
//
//  Created by 俞清源 on 2018/6/5.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CTAppNavViewController.h"

@interface CTAppNavViewController ()

@end

@implementation CTAppNavViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 旋转问题

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;;
}

@end
