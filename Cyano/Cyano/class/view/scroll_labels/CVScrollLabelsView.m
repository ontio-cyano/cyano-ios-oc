//
//  CVScrollLabelsView.m
//  CloudStudy
//
//  Created by Yuanhai on 13/7/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import "CVScrollLabelsView.h"

@interface CVScrollLabelsView ()

@property (strong, nonatomic) NSTimer *customTimer;
@property (strong, nonatomic) NSMutableArray *labels;

@end

@implementation CVScrollLabelsView

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self layoutTitleLabels];
}

- (void)layoutTitleLabels
{
    self.labels = [NSMutableArray array];
    for (int f = 0; f < self.titles.count; f++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(self.width * f, 0.0f, self.width, self.height);
        label.backgroundColor = [UIColor clearColor];
        label.font = AppleFont_UltraLight(14);
        label.textColor = BlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.text = self.titles[f];
        [self addSubview:label];
        [self.labels addObject:label];
    }
}

- (void)startTimer
{
    if ([_customTimer isValid]) [_customTimer invalidate];
    _customTimer = nil;
    self.customTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(moveLabels) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if ([_customTimer isValid]) [_customTimer invalidate];
    _customTimer = nil;
}

- (void)moveLabels
{
    for (int f = 0; f < self.labels.count; f++)
    {
        UILabel *label = self.labels[f];
        [UIView animateWithDuration:controller_animate_duration animations:^{
            label.left -= self.width;
        }];
        if (label.left < 0)
        {
            label.left = (self.labels.count - 1) * self.width;
        }
    }
}

@end
