//
//  GHSegmentControl.m
//  GreenHouse
//
//  Created by Yuanhai on 20/9/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import "GHSegmentControl.h"

#define segmentFont         [UIFont systemFontOfSize:16]
#define selectLineHeight    getUIValue(4.0f)
#define selectLineColor     [ConstantUtil colorFromHex:0x1792e5]
#define TAG_OFFSET          100 //tag is 0 by default, add offset for button.
#define TAG_BADGE           99 //tag for badge label

@interface GHSegmentControl()

@property (nonatomic, strong) UIView *viewSelectedLine;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *arrayWidths;
@property (nonatomic) CGFloat segmentItemWidth;

- (void)recreateSubviews;
- (void)moveSelectedLineToIndex:(NSInteger)selectedIndex;
- (void)buttonSegmentClicked:(id)sender;

@end

@implementation GHSegmentControl

#pragma mark - SET

- (void)setArrayTitles:(NSArray *)arrayTitles
{
    _arrayTitles = arrayTitles;
    self.arrayWidths = [NSMutableArray arrayWithCapacity:arrayTitles.count];
    [self recreateSubviews];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (selectedSegmentIndex >= 0
        && selectedSegmentIndex < self.arrayTitles.count)
    {
        _selectedSegmentIndex = selectedSegmentIndex;
        for (int i = 0 ; i < self.arrayTitles.count; i++)
        {
            UIButton *btn = (UIButton *)[self viewWithTag:i + TAG_OFFSET];
            btn.selected = (i == selectedSegmentIndex);
        }
        [self moveSelectedLineToIndex:selectedSegmentIndex];
        if ([self.controlDelegate respondsToSelector:@selector(selectSegmentIndex:)])
        {
            [self.controlDelegate selectSegmentIndex:selectedSegmentIndex];
        }
    }
}

- (void)updateBadgeAt:(NSInteger)index count:(NSInteger)count
{
    if (index >= 0
        && index < self.arrayTitles.count)
    {
        UIButton *button = [self viewWithTag:index + TAG_OFFSET];
        UILabel *labelBadge = [button viewWithTag:TAG_BADGE];
        if (count > 0)
        {
            labelBadge.hidden = NO;
            labelBadge.text = [NSString stringWithFormat:@"%@", @(count)];
        }
        else
        {
            labelBadge.hidden = YES;
        }
    }
}

#pragma mark - private functions

- (void)recreateSubviews
{
    //remove all controls
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    if (self.arrayTitles.count == 0)
    {
        return; //if no content to show, just clear and end.
    }
    CGFloat itemWidth = self.width / self.arrayTitles.count;
    for (int i = 0; i < self.arrayTitles.count; i++)
    {
        // 自适应，取最长的作为item的宽度
        CGRect tmpTitleRect = [self.arrayTitles[i] boundingRectWithSize:CGSizeMake(100000, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: segmentFont} context:nil];
        [self.arrayWidths addObject:@(tmpTitleRect.size.width)];
        itemWidth = MAX(tmpTitleRect.size.width + frameMove_X, itemWidth);
    }
    self.segmentItemWidth = itemWidth;
    self.contentSize = CGSizeMake(itemWidth * self.arrayTitles.count, self.height);
    for (int i = 0; i < self.arrayTitles.count; i++)
    {
        //创建点击的button
        NSString *title = self.arrayTitles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + TAG_OFFSET;
        btn.frame = CGRectMake(i * itemWidth, 0.0f, itemWidth, self.height);
        btn.titleLabel.font = segmentFont;
        [btn setTitleColor:PurityColor(150) forState:UIControlStateNormal];
        [btn setTitleColor:MainBlueColor forState:UIControlStateSelected];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonSegmentClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //右上角的badge
        UILabel *labelBadge = [[UILabel alloc] init];
        labelBadge.tag = TAG_BADGE;
        float labelRadius = 15.0f;
        float labelX = btn.width / 2 + [self.arrayWidths[i] floatValue] / 2;
        labelBadge.frame = CGRectMake(labelX, 5.0f, labelRadius, labelRadius);
        labelBadge.layer.masksToBounds = YES;
        labelBadge.layer.cornerRadius  = labelRadius / 2;
        labelBadge.backgroundColor = MainBlueColor;
        labelBadge.textColor = WhiteColor;
        labelBadge.font = [UIFont systemFontOfSize:11];
        labelBadge.adjustsFontSizeToFitWidth = YES;
        labelBadge.textAlignment = NSTextAlignmentCenter;
        labelBadge.hidden = YES;
        [btn addSubview:labelBadge];
    }
    
    //选择的高亮横线
    self.viewSelectedLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                     self.height - selectLineHeight,
                                                                     0.0f,
                                                                     selectLineHeight)];
    self.viewSelectedLine.backgroundColor = MainBlueColor;
    [self addSubview:self.viewSelectedLine];
    
    //默认选择第一个
    self.selectedSegmentIndex = 0;
}

- (void)moveSelectedLineToIndex:(NSInteger)selectedIndex
{
    if (selectedIndex >= 0
        && selectedIndex < self.arrayTitles.count)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.viewSelectedLine.width = [self.arrayWidths[selectedIndex] floatValue] + frameMove_X;
            self.viewSelectedLine.left = self.segmentItemWidth * selectedIndex + self.segmentItemWidth / 2 - self.viewSelectedLine.width / 2;
        }];
    }
}

- (void)buttonSegmentClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    self.selectedSegmentIndex = button.tag - TAG_OFFSET;
}

@end
