//
//  CCTableViewCell.h
//  Cyano
//
//  Created by Yuanhai on 13/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

- (void)layoutCellSubviews:(CGRect)frame;
- (void)initData;

+ (float)getCellHeight:(id)model;

@end
