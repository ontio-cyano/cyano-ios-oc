//
//  CVCellIndicator.h
//  CUBE
//
//  Created by Faney on 15/8/14.
//  Copyright (c) 2015年 Faney. All rights reserved.
//

// 箭头指向
typedef enum
{
    Indicator_Type_Down = 1,
    Indicator_Type_Up = 2,
    Indicator_Type_Right = 3,
    Indicator_Type_Right_Blue = 4,
} Indicator_Type;

@interface CVCellIndicator : UIView

@property (assign, nonatomic) NSInteger indicatorType;

@end
