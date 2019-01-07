//
//  CCRoundCell.h
//  Cyano
//
//  Created by Yuanhai on 10/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVCellIndicator.h"

#define cellTopHeight 3.0f

@interface CCRoundCell : CCTableViewCell

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) CVCellIndicator *indicator;

- (void)showIndicator;
- (void)hideIndicator;

@end
