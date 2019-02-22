//
//  CCRoundImageTitleDetailLRCell.m
//  Cyano
//
//  Created by Yuanhai on 11/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCRoundImageTitleDetailLRCell.h"

@implementation CCRoundImageTitleDetailLRCell

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
    // Image
    float imageWidthSpacing = frameMove_X * 0.9;
    float imageHeightSpacing = (self.backView.height - cellIconHeight) / 2;
    self.titleImageView = [self createImageView:self.backView];
    self.titleImageView.frame = CGRectMake(imageWidthSpacing, imageHeightSpacing, cellIconHeight, cellIconHeight);
    
    // Title
    float labelX = self.titleImageView.right + imageWidthSpacing;
    float labelTotalWidth = self.backView.width - frameMove_X - labelX;
    self.titleLabel = [self createLabel:self.backView];
    self.titleLabel.frame = CGRectMake(labelX, 0.0f, labelTotalWidth * 0.35, self.backView.height);
    
    // Detail
    self.detailLabel = [self createLabel:self.backView];
    self.detailLabel.frame = CGRectMake(self.titleLabel.right, 0.0f, labelTotalWidth - self.titleLabel.width, self.backView.height);
    self.detailLabel.textAlignment = NSTextAlignmentRight;
}

@end
