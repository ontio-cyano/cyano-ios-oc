//
//  CCTableViewCell.m
//  Cyano
//
//  Created by Yuanhai on 13/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTableViewCell.h"

@implementation CCTableViewCell

// (继承) Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setFrame:frame];
        self.contentView.frame = self.bounds;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        // Subviews
        [self layoutCellSubviews:frame];
    }
    return self;
}

// (继承) Layout Subviews
- (void)layoutCellSubviews:(CGRect)frame
{
}

// (继承) Cell Height
+ (float)getCellHeight:(id)model
{
    return customCellHeight;
}

// (继承) Init Data
- (void)initData
{
}

@end
