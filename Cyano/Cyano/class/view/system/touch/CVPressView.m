//
//  CVPressView.m
//  FHPlayer
//
//  Created by Faney on 14-9-15.
//  Copyright (c) 2014年 FHPlayer. All rights reserved.
//  点击视图，表面蒙一层黑色板

#import "CVPressView.h"

@interface CVPressView ()

@end

@implementation CVPressView

- (id)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (frame.size.height > 0)
    {
        if (!self.alphaView)
        {
            self.alphaView = [[UIView alloc] init];
            self.alphaView.backgroundColor = [UIColor colorWithRed:20 / 255.0f green:20 / 255.0f blue:20 / 255.0f alpha:0.3f];
            self.alphaView.userInteractionEnabled = NO;
            self.alphaView.hidden = YES;
            self.alphaView.layer.masksToBounds = YES;
            self.alphaView.layer.cornerRadius = self.layer.cornerRadius;
            [self addSubview:self.alphaView];
        }
        self.alphaView.frame = self.bounds;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self bringSubviewToFront:self.alphaView];
    self.alphaView.hidden = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.alphaView.hidden = YES;
}

#pragma
#pragma mark - UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.alphaView.hidden = YES;
}

@end
