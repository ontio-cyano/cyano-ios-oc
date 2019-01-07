//
//  CVShowLabelView.m
//  CUBE
//
//  Created by Faney on 16/3/24.
//  Copyright © 2016年 Faney. All rights reserved.
//  展示Label

#import "CVShowLabelView.h"

@interface CVShowLabelView ()

@property (strong, nonatomic) UIView *showBackView;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) UILabel *detailLabel;

@end

@implementation CVShowLabelView

+ (void)showTitle:(NSString *)title detail:(NSString *)detail
{
    if (title.length <= 0) return;
    CVShowLabelView *showLabelView = [[CVShowLabelView alloc] initShowLabelWithTitle:title detail:detail showType:0];
    [showLabelView show];
}

- (void)show
{
    // 删除其他显示
    UIView *lastShowView = [MainAppDelegate.window viewWithTag:CVShowLabelViewTag];
    [lastShowView removeFromSuperview];
    
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         self.alpha = 1.0f;
     } completion:nil];
    
    // 自动消失
    [self performSelector:@selector(itemPress:) withObject:nil afterDelay:2];
}

- (id)initShowLabelWithTitle:(NSString *)title detail:(NSString *)detail showType:(int)showType
{
    if (self = [self init])
    {
        self.title = title;
        self.detail = detail;
        
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
        self.tag = CVShowLabelViewTag;
        
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
    float frameWidthSpacing = frameMove_X;
    float showWidthSpacing = getUIValue(12.0f);
    float showHeightSpacing = getUIValue(12.0f);
    float showLabelHeightSpacing = frameMove_X * 0.8;
    float labelWidth = self.frame.size.width - frameWidthSpacing * 2 - showWidthSpacing * 2;
    
    float showFrameHeight = 0.0f;
    showFrameHeight += showHeightSpacing;
    
    // Back
    self.showBackView = [[UIView alloc] init];
    self.showBackView.backgroundColor = BlackColor;
    self.showBackView.layer.masksToBounds = YES;
    self.showBackView.layer.cornerRadius = viewBorderRadius;
    [self addSubview:self.showBackView];
    
    // 自适应
    UIFont *titleFont = AppleFont_UltraLight(16);
    CGRect tmpRect = [self.title boundingRectWithSize:CGSizeMake(100000, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleFont, NSFontAttributeName, nil] context:nil];
    if (tmpRect.size.width + showWidthSpacing * 2 > labelWidth)
    {
        tmpRect = [self.title boundingRectWithSize:CGSizeMake(labelWidth, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleFont, NSFontAttributeName, nil] context:nil];
    }
    else
    {
        labelWidth = tmpRect.size.width;
    }
    
    float temHeight = tmpRect.size.height + 1.0f;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(showWidthSpacing, showFrameHeight, labelWidth, temHeight);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = titleFont;
    self.titleLabel.textColor = WhiteColor;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.titleLabel.text = self.title;
    self.titleLabel.numberOfLines = 0;
    [self.showBackView addSubview:self.titleLabel];
    showFrameHeight += temHeight;
    
    if (self.detail && self.detail.length > 0)
    {
        showFrameHeight += showLabelHeightSpacing;
        
        UIFont *detailFont = AppleFont_UltraLight(13);
        // 自适应
        tmpRect = [self.detail boundingRectWithSize:CGSizeMake(labelWidth, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:detailFont, NSFontAttributeName, nil] context:nil];
        temHeight = tmpRect.size.height + 1.0f;
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.frame = CGRectMake(showWidthSpacing, showFrameHeight, labelWidth, temHeight);
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.font = detailFont;
        self.detailLabel.textColor = PurityColor(180);
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        self.detailLabel.text = self.detail;
        self.detailLabel.numberOfLines = 0;
        [self.showBackView addSubview:self.detailLabel];
        showFrameHeight += temHeight;
    }
    showFrameHeight += showHeightSpacing;
    
    float backWidth = labelWidth + showWidthSpacing * 2;
    self.showBackView.frame = CGRectMake((self.frame.size.width - backWidth) / 2, (self.frame.size.height - showFrameHeight) / 2, backWidth, showFrameHeight);
}

- (void)itemPress:(UIControl *)button
{
    [UIView animateWithDuration:0.2f animations:^ {
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
