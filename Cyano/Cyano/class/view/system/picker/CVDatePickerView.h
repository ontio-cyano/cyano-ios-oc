//
//  CVDatePickerView.h
//  iQBTeacher
//
//  Created by Yuanhai on 12/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    DateStyleShowYearMonthDay = 0, // 年月日
    DateStyleShowYearMonthDayHourMinute, // 年月日时分
} CVDateStyle;

typedef void(^HourPickerGetter)(NSDate *selectDate);

@interface CVDatePickerView : UIControl

@property (strong, nonatomic) HourPickerGetter hourPickerGetter;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) CVDateStyle dateStyle;

// 滚到指定日期
@property (strong, nonatomic) NSDate *scrollToDate;

- (id)initWithDateStyle:(CVDateStyle)dateStyle;

- (void)show;

@end
