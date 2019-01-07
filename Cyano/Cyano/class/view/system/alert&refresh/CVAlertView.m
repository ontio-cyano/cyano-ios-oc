//
//  CVAlertView.m
//  CUBE
//
//  Created by Faney on 15/10/12.
//  Copyright © 2015年 Faney. All rights reserved.
//  对话框

#import "CVAlertView.h"

@interface CVAlertView ()

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *detail;

@property (strong, nonatomic) NSArray *toolItems;

@end

@implementation CVAlertView

- (void)show
{
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         self.alpha = 1.0f;
     } completion:nil];
}

- (id)initWithTitle:(NSString *)title detail:(NSString *)detail needCancel:(BOOL)needCancel delegate:(id<CVAlertViewDelegate>)delegate
{
    if (self = [self init])
    {
        self.delegate = delegate;
        self.title = title;
        self.detail = detail;
        
        // 是否需要取消
        if (needCancel)
        {
            self.toolItems = [NSArray arrayWithObjects:@"alert_cancel.png", @"alert_ok.png", nil];
        }
        else
        {
            self.toolItems = [NSArray arrayWithObjects:@"alert_ok.png", nil];
        }
        
        // 显示对话框
        [self initShowOutView];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
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
    float showWidthSpacing = frameMove_X * 1.75;
    float showHeightSpacing = showWidthSpacing;
    float showLabelHeightSpacing = frameMove_X * 0.8;
    float buttonWidth = (self.frame.size.width - frameWidthSpacing * 2) / self.toolItems.count;
    float buttonImageRadius = toolDownViewHeight * 0.5f;
    float labelWidth = self.frame.size.width - frameWidthSpacing * 2 - showWidthSpacing * 2;
    
    float showFrameHeight = 0.0f;
    showFrameHeight += showHeightSpacing;
    
    // Back
    UIView *showBackView = [[UIView alloc] init];
    showBackView.backgroundColor = [UIColor whiteColor];
    showBackView.layer.masksToBounds = YES;
    showBackView.layer.cornerRadius = viewBorderRadius;
    [self addSubview:showBackView];
    
    UIFont *titleFont = AppleFont_UltraLight(16);
    // 自适应
    CGRect tmpRect = [self.title boundingRectWithSize:CGSizeMake(labelWidth, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleFont, NSFontAttributeName, nil] context:nil];
    float temHeight = tmpRect.size.height + 1.0f;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(showWidthSpacing, showFrameHeight, labelWidth, temHeight);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = titleFont;
    titleLabel.textColor = BlackColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    titleLabel.numberOfLines = 0;
    [showBackView addSubview:titleLabel];
    showFrameHeight += temHeight;
    
    if (self.detail && self.detail.length > 0)
    {
        showFrameHeight += showLabelHeightSpacing;
        
        UIFont *detailFont = AppleFont_UltraLight(13);
        // 自适应
        tmpRect = [self.detail boundingRectWithSize:CGSizeMake(labelWidth, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:detailFont, NSFontAttributeName, nil] context:nil];
        temHeight = tmpRect.size.height + 1.0f;
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.frame = CGRectMake(showWidthSpacing, showFrameHeight, labelWidth, temHeight);
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.font = detailFont;
        detailLabel.textColor = PurityColor(170);
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = self.detail;
        detailLabel.numberOfLines = 0;
        [showBackView addSubview:detailLabel];
        showFrameHeight += temHeight;
    }
    
    showFrameHeight += showHeightSpacing;
    
    // Tool
    for (int f = 0; f < self.toolItems.count; f++)
    {
        CVParentButton *button = [[CVParentButton alloc] init];
        button.tag = f + 1;
        button.frame = CGRectMake(f * buttonWidth, showFrameHeight, buttonWidth, toolDownViewHeight);
        [button addTarget:self action:@selector(itemPress:) forControlEvents:UIControlEventTouchUpInside];
        [showBackView addSubview:button];
        if (f == self.toolItems.count - 1)
        {
            button.backgroundColor = MainOrangeColor;
        }
        else
        {
            button.backgroundColor = [UIColor colorWithRed:143 / 255.0f green:143 / 255.0f blue:143 / 255.0f alpha:1.0f];
        }
        
        // Image
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((button.frame.size.width - buttonImageRadius) / 2, (button.frame.size.height - buttonImageRadius) / 2, buttonImageRadius, buttonImageRadius);
        imageView.image = [UIImage imageNamed:[self.toolItems objectAtIndex:f]];
        [button addSubview:imageView];
    }
    showFrameHeight += toolDownViewHeight;
    
    showBackView.frame = CGRectMake(frameWidthSpacing, (self.frame.size.height - showFrameHeight) / 2, self.frame.size.width - frameWidthSpacing * 2, showFrameHeight);
}

- (void)itemPress:(UIControl *)button
{
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         self.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         if ([button isKindOfClass:[CVParentButton class]] && self.delegate)
         {
             [self.delegate CVAlertView:self selected:(int)button.tag];
         }
         [self removeFromSuperview];
     }];
}

@end
