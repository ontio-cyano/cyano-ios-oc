//
//  CVParentControl.m
//  CUBE
//
//  Created by Faney on 16/6/28.
//  Copyright © 2016年 Faney. All rights reserved.
//  顶级父类Control

#import "CVParentControl.h"

@implementation CVParentControl

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(canTouch) withObject:nil afterDelay:control_enable_timer];
}

- (void)canTouch
{
    self.userInteractionEnabled = YES;
}

@end
