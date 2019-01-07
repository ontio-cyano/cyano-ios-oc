//
//  CVWalletBalancesView.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVWalletBalancesView.h"

#define headerHeight getUIValue(200.0f)
#define toolHeight getUIValue(60.0f)

@interface CVWalletBalancesView ()

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *ontValueLabel;
@property (strong, nonatomic) UILabel *ongValueLabel;
@property (strong, nonatomic) UILabel *claimValueLabel;

@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *toolView;

@end

@implementation CVWalletBalancesView

- (void)layoutMainView
{
    // Header
    [self layoutHeaderView];
    
    // Tool
    [self layoutToolView];
    
    // Content
    [self layoutContentView];
    
    // Data
    [self updateData];
}

#pragma mark - Data

- (void)updateData
{
    ONTAccount *account = [GCHApplication requestDefaultAccount];
    [[ONTRpcApi shareInstance] getBalanceWithAddress:account.address.address callback:^(NSArray *balances, NSError *error) {
        if (error) return;
        for (ONTBalance *balance in balances)
        {
            NSLog(@"%@ == %@", balance.name, balance.balances);
            if ([[balance.name uppercaseString] isEqualToString:@"ONT"])
            {
                self.ontValueLabel.text = balance.balances;
            }
            else if ([[balance.name uppercaseString] isEqualToString:@"ONG"])
            {
                self.ongValueLabel.text = balance.balances;
            }
            else if ([[balance.name uppercaseString] isEqualToString:@"CLAIM"])
            {
                self.claimValueLabel.text = balance.balances;
            }
        }
    }];
}

#pragma mark - Header

- (void)layoutHeaderView
{
    if (!self.headerView)
    {
        self.headerView = [self createView:self];
        self.headerView.frame = CGRectMake(0.0f, 0.0f, self.width, headerHeight);
    }
    
    for (UIView *view in self.headerView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Icon
    float iconSpacing = getUIValue(10.0f);
    float iconWidth = getUIValue(40.0f);
    float iconHeight = iconWidth * 176 / 196;
    UIImageView *iconImageView = [self createImageView:self.headerView];
    iconImageView.frame = CGRectMake(iconSpacing, NavigationStatusBarHeight + iconSpacing, iconWidth, iconHeight);
    iconImageView.image = [UIImage imageNamed:@"logo"];
    
    // Title
    UILabel *titleLabel = [self createLabel:self.headerView];
    titleLabel.frame = CGRectMake(iconImageView.right + iconSpacing, iconImageView.top, self.headerView.width - iconImageView.right - iconSpacing - frameMove_X, iconImageView.height);
    titleLabel.text = @"Balances";
    titleLabel.font = AppleFont_Thin(35);
    titleLabel.textColor = WhiteColor;
    
    // Values
    float labelsHeightSpacing = getUIValue(10);
    float labelsTop = iconImageView.bottom + labelsHeightSpacing;
    float labelWidth = self.headerView.width / 2;
    float labelHeight = (self.headerView.height - labelsTop - labelsHeightSpacing) / 3;
    float labelLargeHeight = labelHeight * 2;
    for (int f = 0; f < 5; f++)
    {
        UILabel *label = [self createLabel:self.headerView];
        label.font = AppleFont_UltraLight(22);
        label.textColor = WhiteColor;
        label.textAlignment = NSTextAlignmentCenter;
        
        // ONT
        if (f == 0)
        {
            label.text = @"ONT";
            label.frame = CGRectMake(0.0f, labelsTop, labelWidth, labelHeight);
        }
        // ONG
        else if (f == 1)
        {
            label.text = @"ONG";
            label.frame = CGRectMake(labelWidth, labelsTop, labelWidth, labelHeight);
        }
        // ONT Value
        else if (f == 2)
        {
            self.ontValueLabel = label;
            label.font = AppleFont_Thin(40);
            label.text = @"0";
            label.frame = CGRectMake(0.0f, labelsTop + labelHeight, labelWidth, labelLargeHeight);
        }
        // ONG Value
        else if (f == 3)
        {
            self.ongValueLabel = label;
            label.text = @"0";
            label.frame = CGRectMake(labelWidth, labelsTop + labelHeight, labelWidth, labelHeight);
        }
        // Claim
        else if (f == 4)
        {
            self.claimValueLabel = label;
            label.text = @"0 (Claim)";
            label.frame = CGRectMake(labelWidth, labelsTop + labelHeight * 2, labelWidth, labelHeight);
        }
    }
}

#pragma mark - Content

- (void)layoutContentView
{
    if (!self.contentView)
    {
        self.contentView = [self createView:self];
        self.contentView.frame = CGRectMake(0.0f, self.headerView.bottom, self.width, self.toolView.top - self.headerView.bottom);
        self.contentView.backgroundColor = PurityColor(242);
    }
    
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Title
    float titleWidthSpacing = getUIValue(10.0f);
    float titleHeightSpacing = getUIValue(20.0f);
    float titleHeight = getUIValue(40.0f);
    UILabel *titleLabel = [self createLabel:self.contentView];
    titleLabel.frame = CGRectMake(titleWidthSpacing, titleHeightSpacing, self.contentView.width - titleWidthSpacing * 2, titleHeight);
    titleLabel.text = @"OEP-4 tokens";
    titleLabel.font = AppleFont_Thin(35);
    titleLabel.textColor = RGBCOLOR(79, 77, 77);
}

#pragma mark - Tool

- (void)layoutToolView
{
    if (!self.toolView)
    {
        self.toolView = [self createView:self];
        self.toolView.frame = CGRectMake(0.0f, self.height - tabBarHeight - toolHeight, self.width, toolHeight);
        self.toolView.backgroundColor = PurityColor(242);
    }
    
    for (UIView *view in self.toolView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Items
    NSArray *itemsArr = @[@"SEND", @"RECEIVE"];
    float itemWidth = getUIValue(100.0f);
    float itemHeight = getUIValue(40.0f);
    float itemWidthSpacing = getUIValue(4.0f);
    float totalWidth = itemsArr.count * itemWidth + (itemsArr.count - 1) * itemWidthSpacing;
    for (int f = 0; f < itemsArr.count; f++)
    {
        UIButton *button = [self createButton:self.toolView];
        button.tag = f + 1;
        [button addTarget:self action:@selector(buttonItemPress:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((self.toolView.width - totalWidth) / 2 + (itemWidth + itemWidthSpacing) * f, 0.0f, itemWidth, itemHeight);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2.0f;
        [button setTitle:itemsArr[f] forState:UIControlStateNormal];
        [button setTitleColor:MainBlueColor forState:UIControlStateNormal];
        button.backgroundColor = RGBCOLOR(224, 225, 226);
        button.titleLabel.font = AppleFont_Regular(14);
        
        // Shadow
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:button.layer.cornerRadius];
        button.layer.masksToBounds = NO;
        button.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        button.layer.shadowOpacity = 0.5f;
        button.layer.shadowPath = shadowPath.CGPath;
        button.layer.shadowColor = PurityColor(240).CGColor;
    }
}

#pragma mark - 按钮点击

- (void)buttonItemPress:(UIButton *)button
{
    // SEND
    if (button.tag == 1)
    {
        
    }
    // RECEIVE
    else if (button.tag == 2)
    {
        
    }
}

@end
