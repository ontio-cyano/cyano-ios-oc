//
//  CVParentButton.m
//  CUBE
//
//  Created by Faney on 16/6/28.
//  Copyright © 2016年 Faney. All rights reserved.
//  顶级父类Button

#import "CVParentButton.h"

#define HightLightedTextColor PurityColor(150)

@implementation CVParentButton

- (id)init
{
    if (self = [super init])
    {
        [self setTitleColor:HightLightedTextColor forState:UIControlStateHighlighted];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setTitleColor:HightLightedTextColor forState:UIControlStateHighlighted];
    }
    return self;
}

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
