//
//  CCLineCell.h
//  DaiGuanJia
//
//  Created by Faney on 16/11/7.
//  Copyright © 2016年 honeywell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVCellIndicator.h"

@interface CCLineCell : UITableViewCell

@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) CVCellIndicator *indicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

- (void)showIndicator;
- (void)hideIndicator;

+ (float)getCellHeight:(id)model;
- (void)initData;

@end
