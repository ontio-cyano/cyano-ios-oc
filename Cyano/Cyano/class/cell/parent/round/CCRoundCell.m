//
//  CCRoundCell.m
//  Cyano
//
//  Created by Yuanhai on 10/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCRoundCell.h"

@implementation CCRoundCell

// (继承) Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setFrame:frame];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        // Back
        self.backView = [self createView:self.contentView];
        self.backView.frame = CGRectMake(frameMove_X, cellTopHeight, self.width - frameMove_X * 2, self.height - cellTopHeight);
        self.backView.backgroundColor = PurityColor(247);
        self.backView.layer.cornerRadius = 10.0f;
        
        // 阴影
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds cornerRadius:self.backView.layer.cornerRadius];
        self.backView.layer.masksToBounds = NO;
        self.backView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.backView.layer.shadowOpacity = 0.5f;
        self.backView.layer.shadowPath = shadowPath.CGPath;
        self.backView.layer.shadowColor = PurityColor(200).CGColor;
        
        // Indicator
        float indicatorSpacing = frameMove_X * 0.9;
        self.indicator = [[CVCellIndicator alloc] init];
        self.indicator.userInteractionEnabled = NO;
        self.indicator.indicatorType = Indicator_Type_Right;
        self.indicator.frame = CGRectMake(self.backView.width - indicatorHeight - indicatorSpacing, (self.backView.height - indicatorHeight) / 2, indicatorHeight, indicatorHeight);
        self.indicator.hidden = YES;
        [self.backView addSubview:self.indicator];
        
        // Subviews
        [self layoutCellSubviews:frame];
    }
    return self;
}

- (void)showIndicator
{
    self.indicator.hidden = NO;
    [self.backView bringSubviewToFront:self.indicator];
    for (UIView *view in self.backView.subviews)
    {
        if (view != self.indicator && view.right > self.indicator.left)
        {
            view.width -= self.indicator.width;
        }
    }
}

- (void)hideIndicator
{
    for (UIView *view in self.backView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Subviews
    [self layoutCellSubviews:self.frame];
}

@end
