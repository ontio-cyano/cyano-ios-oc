//
//  CVMenuView.m
//  CUBE
//
//  Created by Faney on 15/8/31.
//  Copyright (c) 2015年 Faney. All rights reserved.
//  导航条菜单

#import "CVMenuView.h"
#import "CVMenuBackView.h"

@interface CVMenuView()

@property(strong, nonatomic) NSArray *titles;

@end

@implementation CVMenuView

- (void)show
{
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
}

- (id)initWithTitles:(NSArray *)titles top:(float)top center:(float)center
{
    if (self = [super init])
    {
        self.titles = titles;
        self.frame = MainAppDelegate.window.bounds;
        [self addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        // Frame
        float buttonHeight = 35.0f;
        float buttonWidth = 120.0f;
        float widthSpacing = 15.0f;
        
        // BackView
        CVMenuBackView *backView = [[CVMenuBackView alloc] init];
        backView.frame = CGRectMake(center - buttonWidth / 2, top, buttonWidth, buttonHeight * titles.count + backView.triangleHeight);
        [self addSubview:backView];
        
        // 阴影
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(backView.left, backView.top + backView.triangleHeight, backView.width, backView.height - backView.triangleHeight)];
        [self insertSubview:shadowView belowSubview:backView];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowView.bounds cornerRadius:backView.radius];
        shadowView.layer.masksToBounds = NO;
        shadowView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        shadowView.layer.shadowOpacity = 0.5f;
        shadowView.layer.shadowPath = shadowPath.CGPath;
        
        // Titles
        for (int f = 0; f < titles.count; f++)
        {
            CVParentButton *titleButton = [[CVParentButton alloc] init];
            titleButton.tag = f + 1;
            titleButton.frame = CGRectMake(0.0f, backView.triangleHeight + buttonHeight * f, backView.frame.size.width, buttonHeight);
            [titleButton addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
            [titleButton setTitleColor:BlackColor forState:UIControlStateNormal];
            [titleButton setTitle:titles[f] forState:UIControlStateNormal];
            titleButton.titleLabel.font = AppleFont_UltraLight(14);
            titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0.0f, widthSpacing, 0.0f, widthSpacing);
            [backView addSubview:titleButton];
            
            // Line
            if (f < titles.count - 1)
            {
                float lineSpacing = 0.0f;
                UIView *lineView = [self createView:titleButton];
                lineView.backgroundColor = tableLineColor;
                lineView.frame = CGRectMake(lineSpacing, titleButton.frame.size.height - table_line_height, titleButton.frame.size.width - lineSpacing * 2, table_line_height);
            }
        }
    }
    return self;
}

- (void)menuItemPressed:(UIControl *)button
{
    NSInteger selectIndex = button.tag - 1;
    if ([button isKindOfClass:[UIButton class]] && self.callBack) self.callBack(self.titles[selectIndex]);
    
    [self removeFromSuperview];
}

@end
