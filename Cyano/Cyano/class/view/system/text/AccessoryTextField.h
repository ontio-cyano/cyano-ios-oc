//
//  AccessoryTextField.h
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccessoryTextField : UITextField  <UITextFieldDelegate>

@end


/*
 限制输入长度
 */

@interface LimitTextField : AccessoryTextField

@property (assign, nonatomic) int limitInputLength;

@end


/*
 只能输入4位，小数点后只能一位
 */

@interface OneDecimalsTextField : LimitTextField

//限制小数点前的位数，如果为0是无限制
@property (nonatomic) NSInteger numberBeforeDot;
//限制小数点后的位数
@property (nonatomic) NSInteger numberAfterDot;

@end


/*
 电话号码输入
 */

@interface PhoneTextField : LimitTextField
@end

