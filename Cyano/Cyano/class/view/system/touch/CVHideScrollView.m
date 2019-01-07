//
//  CVHideScrollView.m
//  Cyano
//
//  Created by Yuanhai on 7/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVHideScrollView.h"

@implementation CVHideScrollView

#pragma mark - UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self endEditing:NO];
}

@end
