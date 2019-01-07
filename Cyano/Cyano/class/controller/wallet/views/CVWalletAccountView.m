//
//  CVWalletAccountView.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVWalletAccountView.h"
#import "CTNewAccountViewController.h"
#import "CTImportPrivateKeyViewController.h"

@implementation CVWalletAccountView

- (void)layoutMainView
{
    // Frame
    float iconWidth = self.width * 0.3;
    float iconHeight = iconWidth * 176 / 196;
    float labelWidthSpacing = frameMove_X;
    float titleHeight = getUIValue(45.0f);
    float detailHeight = getUIValue(20.0f);
    float noticeHeightSpacing = getUIValue(20.0f);
    float noticeHeight = getUIValue(60.0f);
    
    // Icon
    float topSpacing = getUIValue(60.0f);
    UIImageView *iconImageView = [self createImageView:self];
    iconImageView.frame = CGRectMake((self.width - iconWidth) / 2, topSpacing, iconWidth, iconHeight);
    iconImageView.image = [UIImage imageNamed:@"logo"];
    
    // Title
    float titleHeightSpacing = getUIValue(20.0f);
    UILabel *titleLabel = [self createLabel:self];
    titleLabel.frame = CGRectMake(labelWidthSpacing, iconImageView.bottom + titleHeightSpacing, self.width - labelWidthSpacing * 2, titleHeight);
    titleLabel.text = @"Cyano Wallet";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = AppleFont_Thin(45);
    titleLabel.textColor = WhiteColor;
    
    // Detail
    UILabel *detailLabel = [self createLabel:self];
    detailLabel.frame = CGRectMake(titleLabel.left, titleLabel.bottom, titleLabel.width, detailHeight);
    detailLabel.text = @"an Ontology wallet";
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = AppleFont_UltraLight(16);
    detailLabel.textColor = PurityColor(240);
    
    // Notice
    UILabel *noticeLabel = [self createLabel:self];
    noticeLabel.frame = CGRectMake(titleLabel.left, detailLabel.bottom + noticeHeightSpacing, titleLabel.width, noticeHeight);
    noticeLabel.text = @"To start using Ontology\ncreate a new account or import an existing one.";
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.font = AppleFont_Regular(16);
    noticeLabel.textColor = WhiteColor;
    
    // Items
    NSArray *itemsArr = @[@"NEW ACCOUNT", @"IMPORT PRIVATE KEY"];
    float itemWidth = self.width * 0.5;
    float itemHeight = getUIValue(40.0f);
    float itemHeightSpacing = getUIValue(10.0f);
    for (int f = 0; f < itemsArr.count; f++)
    {
        UIButton *button = [self createButton:self];
        button.tag = f + 1;
        [button addTarget:self action:@selector(buttonItemPress:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((self.width - itemWidth) / 2, noticeLabel.bottom + noticeHeightSpacing + (itemHeight + itemHeightSpacing) * f, itemWidth, itemHeight);
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
    // NEW ACCOUNT
    if (button.tag == 1)
    {
        CTNewAccountViewController *controller = [[CTNewAccountViewController alloc] init];
        [MainAppDelegate.navigationController pushViewController:controller animated:YES];
    }
    // IMPORT PRIVATE KEY
    else if (button.tag == 2)
    {
        CTImportPrivateKeyViewController *controller = [[CTImportPrivateKeyViewController alloc] init];
        [MainAppDelegate.navigationController pushViewController:controller animated:YES];
    }
}

@end
