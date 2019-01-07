//
//  CCLineCell.m
//  DaiGuanJia
//
//  Created by Faney on 16/11/7.
//  Copyright © 2016年 honeywell. All rights reserved.
//  Cell加底线

#import "CCLineCell.h"

@implementation CCLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setFrame:frame];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        
        // Indicator
        float indicatorSpacing = frameMove_X * 1.9;
        self.indicator = [[CVCellIndicator alloc] init];
        self.indicator.userInteractionEnabled = NO;
        self.indicator.indicatorType = Indicator_Type_Right;
        self.indicator.frame = CGRectMake(frame.size.width - indicatorHeight - indicatorSpacing, (frame.size.height - indicatorHeight) / 2, indicatorHeight, indicatorHeight);
        self.indicator.hidden = YES;
        [self.contentView addSubview:self.indicator];
        
        // Line
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(0.0f, frame.size.height - table_line_height, frame.size.width, table_line_height);
        self.lineView.backgroundColor = tableLineColor;
        [self.contentView addSubview:self.lineView];
        
        // Subviews
        [self layoutCellSubviews:frame];
    }
    return self;
}

- (void)showIndicator
{
    self.indicator.hidden = NO;
    [self.contentView bringSubviewToFront:self.indicator];
    for (UIView *view in self.contentView.subviews)
    {
        if (view != self.indicator && view.right >= self.indicator.left - frameMove_X)
        {
            view.width -= frameMove_X;
            NSLog(@"view:%@", view);
        }
    }
}

- (void)hideIndicator
{
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // Subviews
    [self layoutCellSubviews:self.frame];
}

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
}

// (继承) Cell Height
+ (float)getCellHeight:(id)model
{
    return 0.0f;
}

// (继承) Init Data
- (void)initData
{
}

@end
