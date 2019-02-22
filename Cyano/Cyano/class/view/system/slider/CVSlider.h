//
//  CVSlider.h
//  CUBE
//
//  Created by Faney on 15/12/7.
//  Copyright © 2015年 Faney. All rights reserved.
//

@interface CVSlider : UIView
{
    float maximumValue;
    float minimumValue;
}

// 滑动设置数值
@property (assign, nonatomic) float value;

- (void)updateMinValue:(float)minValue maxValue:(float)maxValue;

// 更新Value
- (void)updateValue:(float)value;

@end
