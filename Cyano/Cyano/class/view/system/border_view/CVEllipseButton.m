//
//  CVEllipseButton.m
//  CloudStudy
//
//  Created by Yuanhai on 24/6/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import "CVEllipseButton.h"

@implementation CVEllipseButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.height / 2;
    self.backgroundColor = MainOrangeColor;
}

@end
