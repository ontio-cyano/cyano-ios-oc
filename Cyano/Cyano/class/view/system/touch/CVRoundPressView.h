//
//  CVRoundPressView.h
//  DaiGuanJia
//
//  Created by Faney on 16/11/2.
//  Copyright © 2016年 honeywell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVRoundPressView : CVPressView

- (id)initWithFrame:(CGRect)frame radius:(float)radius;

- (void)showShadow:(UIColor *)color;

@end
