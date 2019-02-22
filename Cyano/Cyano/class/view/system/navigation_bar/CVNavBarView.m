//
//  CVNavBarView.m
//  WirelessHome
//
//  Created by Faney on 13-8-27.
//  导航条

#import "CVNavBarView.h"

#define mainColor 91 / 255.0f, 177 / 255.0f, 206 / 255.0f, 1.0f
#define maskColor 0 / 255.0f, 0 / 255.0f, 0 / 255.0f, 0.7f

@interface CVNavBarView ()

@property (assign, nonatomic) float statusHeight;

@end

@implementation CVNavBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.statusHeight = NavigationStatusBarHeight;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 隐藏状态栏
- (void)hiddenStatusBar
{
    // Frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - NavigationStatusBarHeight);
    for (UIView *view in self.subviews)
    {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - NavigationStatusBarHeight, view.frame.size.width, view.frame.size.height);
    }
    
    // 重画
    self.statusHeight = 0.0f;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)boxRect
{
    if (self.barType == NavigationBarType_None)
    {
        // 什么都没有
    }
    else if (self.barType == NavigationBarType_Normal)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // 渐变色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){mainColor});
        CGColorRef centerColor = CGColorCreate(colorSpaceRef, (CGFloat[]){mainColor});
        CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){mainColor});
        CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, centerColor, endColor}, 3, nil);
        CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){0.0f, 0.5, 1.0f});
        CFRelease(colorArray);
        CGColorRelease(beginColor);
        CGColorRelease(endColor);
        CGColorSpaceRelease(colorSpaceRef);
        CGContextDrawLinearGradient(context, gradientRef, CGPointMake(boxRect.origin.x, boxRect.origin.y), CGPointMake(boxRect.origin.x + boxRect.size.width, boxRect.origin.y + boxRect.size.height), 0);
        CGGradientRelease(gradientRef);
        CGContextDrawPath(context, kCGPathEOFillStroke);
    }
    else if (self.barType == NavigationBarType_CurveLine)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, mainColor);
        
        CGContextMoveToPoint(context, 0.0f, 0.0f);
        CGContextAddLineToPoint(context, 0.0f, boxRect.size.height - navigationCurveHeight);
        CGContextAddQuadCurveToPoint(context, boxRect.size.width / 2, boxRect.size.height, boxRect.size.width, boxRect.size.height - navigationCurveHeight);
        CGContextAddLineToPoint(context, boxRect.size.width, 0.0f);
        CGContextAddLineToPoint(context, 0.0f, 0.0f);
        
        CGContextFillPath(context);
    }
    else if (self.barType == NavigationBarType_Mask)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, maskColor);
        CGContextFillRect(context, boxRect);
    }
}

@end
