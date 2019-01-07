//
//  CVSimpleSlider.h
//  CUBE
//
//  Created by Faney on 15/8/28.
//  Copyright (c) 2015年 Faney. All rights reserved.
//

@protocol CVSimpleSliderDelegate;

@interface CVSimpleSlider : UIView
{
    float maximumValue;
    float minimumValue;
}

@property (weak, nonatomic) id <CVSimpleSliderDelegate> delegate;

// 滑动设置数值
@property (assign, nonatomic) float value;

- (void)updateMinValue:(float)minValue maxValue:(float)maxValue;

// 更新Value
- (void)updateValue:(float)value;

@end

@protocol CVSimpleSliderDelegate

@required
- (void)CVSimpleSliderTouched:(CVSimpleSlider *)slider;

@optional
- (void)CVSimpleSliderMoved:(CVSimpleSlider *)slider;

@end
