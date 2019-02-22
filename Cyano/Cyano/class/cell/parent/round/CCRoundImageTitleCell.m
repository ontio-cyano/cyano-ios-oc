//
//  CCRoundImageTitleCell.m
//  GreenHouse
//
//  Created by Yuanhai on 2/3/17.
//  Copyright © 2017年 Yuanhai. All rights reserved.
//

#import "CCRoundImageTitleCell.h"

@implementation CCRoundImageTitleCell

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
    self.titleLabel = [self createLabel:self.backView];
    self.titleLabel.frame = CGRectMake(labelX, 0.0f, self.backView.width - frameMove_X - labelX, self.backView.height);
}

@end
