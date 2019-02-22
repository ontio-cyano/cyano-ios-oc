//
//  CVShowNotificationView.m
//  Cyano
//
//  Created by Yuanhai on 5/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVShowNotificationView.h"

@interface CVShowNotificationView ()

@property (strong, nonatomic) void (^callBack)(void);
@property (strong, nonatomic) UIView *showBackView;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation CVShowNotificationView

+ (void)showTitle:(NSString *)title callBack:(void(^)(void))callBack
{
    if (title.length <= 0) return;
    CVShowNotificationView *showLabelView = [[CVShowNotificationView alloc] initWithTitle:title callBack:callBack];
    [showLabelView show];
}

- (void)show
{
    // 删除其他显示
    UIView *lastShowView = [MainAppDelegate.window viewWithTag:CVShowNotificationViewTag];
    [lastShowView removeFromSuperview];
    
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
    
    self.top = - self.height;
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         self.top = 0.0f;
     } completion:nil];
    
    // 自动消失
    [self performSelector:@selector(itemPress:) withObject:nil afterDelay:5.0f];
}

- (id)initWithTitle:(NSString *)title callBack:(void(^)(void))callBack
{
    if (self = [self init])
    {
        self.title = title;
        self.callBack = callBack;
        
        // 显示对话框
        [self initShowOutView];
        
        // 其他地方点击
        [self addTarget:self action:@selector(itemPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tag = CVShowNotificationViewTag;
        
        // Frame
        self.frame = MainAppDelegate.window.bounds;
        
        // Back Color
        self.backgroundColor = PopViewBackColor;
    }
    return self;
}

// 显示对话框
- (void)initShowOutView
{
    // Frame
    float frameSpacing = 0;
    float showWidthSpacing = frameMove_X;
    float showHeightSpacing = frameMove_X;
    float showBackWidth = self.width - frameSpacing * 2;
    float labelWidth = showBackWidth - showWidthSpacing * 2;
    
    float showBackHeight = 0.0f;
    
    // Back
    self.showBackView = [self createView:self];
    self.showBackView.backgroundColor = WhiteColor;
    self.showBackView.userInteractionEnabled = NO;
    
    // 自适应
    UIFont *titleFont = AppleFont_UltraLight(16);
    CGRect tmpRect = [self.title boundingRectWithSize:CGSizeMake(labelWidth, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleFont, NSFontAttributeName, nil] context:nil];
    float temHeight = MAX(tmpRect.size.height + 1.0f, getUIValue(40.0f));
    self.titleLabel = [self createLabel:self.showBackView];
    self.titleLabel.frame = CGRectMake(showWidthSpacing, NavigationStatusBarHeight + showHeightSpacing, labelWidth, temHeight);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.titleLabel.font = titleFont;
    self.titleLabel.textColor = BlackColor;
    self.titleLabel.text = self.title;
    
    // 装饰Line
    float lineHeightSpacing = 5.0f;
    float lineHeight = 2.0f;
    float lineWidth = showBackWidth * 0.2;
    UIView *lineView = [self createView:self.showBackView];
    lineView.frame = CGRectMake((showBackWidth - lineWidth) / 2, self.titleLabel.bottom + lineHeightSpacing, lineWidth, lineHeight);
    lineView.backgroundColor = RGBACOLOR(0, 0, 0, 0.8f);
    lineView.layer.cornerRadius = lineHeight / 2;
    showBackHeight += lineView.bottom + showHeightSpacing;
    
    self.showBackView.frame = CGRectMake(frameSpacing, frameSpacing, showBackWidth, showBackHeight);
    self.height = self.showBackView.bottom + frameSpacing;
}

- (void)itemPress:(UIControl *)button
{
    [UIView animateWithDuration:0.2f animations:^ {
        self.top = - self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (button && self.callBack)
        {
            self.callBack();
        }
    }];
}

@end
