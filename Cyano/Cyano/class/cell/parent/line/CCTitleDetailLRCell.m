//
//  CCTitleDetailLRCell.m
//  iQBTeacher
//
//  Created by Yuanhai on 28/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CCTitleDetailLRCell.h"

@implementation CCTitleDetailLRCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier frame:frame])
    {
        // Title
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.frame = CGRectMake(frameMove_X, 0.0f, frame.size.width / 2 - frameMove_X, frame.size.height);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = AppleFont_UltraLight(18);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.userInteractionEnabled = NO;
        self.titleLabel.textColor = PurityColor(40);
        [self.contentView addSubview:self.titleLabel];
        
        // Detail
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width, 0.0f, frame.size.width - self.titleLabel.frame.origin.x - self.titleLabel.frame.size.width - frameMove_X, frame.size.height);
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.font = AppleFont_UltraLight(18);
        self.detailLabel.textAlignment = NSTextAlignmentRight;
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.userInteractionEnabled = NO;
        self.detailLabel.textColor = PurityColor(125);
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}

@end
