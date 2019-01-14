//
//  Common.h
//  ONTO
//
//  Created by Zeus.Zhang on 2018/2/1.
/*
 * **************************************************************************************
 *  Copyright © 2014-2018 Ontology Foundation Ltd.
 *  All rights reserved.
 *
 *  This software is supplied only under the terms of a license agreement,
 *  nondisclosure agreement or other written agreement with Ontology Foundation Ltd.
 *  Use, redistribution or other disclosure of any parts of this
 *  software is prohibited except in accordance with the terms of such written
 *  agreement with Ontology Foundation Ltd. This software is confidential
 *  and proprietary information of Ontology Foundation Ltd.
 *
 * **************************************************************************************
 *///

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Helper : NSObject


/**
 调用系统相机
 
 @param viewController 调用的VC
 */
+ (void)takePhoto:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)viewController;

/**
 调用相册
 
 @param viewController 调用的VC
 @param edit 是否可裁剪
 */
+ (void)choosePhoto:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)viewController allowsEdit:(BOOL)edit;




/**
 字典转字符串
 
 @param dic 字典
 @return 字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 json字符串转字典
 
 @param jsonString json
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)aStr;

+ (BOOL)dx_isNullOrNilWithObject:(id)object;


/**
 数字加，
 
 @param num 传入数字
 @return 加，数字
 */
+ (NSString *)countNumAndChangeformat:(NSString *)num;


//判断身份是否过期
+ (BOOL)judgeisExpireWithOntId:(NSString *)ontId;
//判断密码是否匹配
+ (BOOL)judgePasswordisMatchWithPassWord:(NSString *)password WithOntId:(NSString *)ontId;

+ (NSDictionary *)claimdencode:(NSString *)base64String;

+ (NSString *)getNowTimeTimestamp;

+ (long)getboxTimestamp;
//密码转义
+ (NSString *)transferredMeaning:(NSString *)password;

//调整lable行间距
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;

// 固定到9位精度，也可以去掉末尾多余的0
+ (NSString *)getPrecision9Str:(NSString *)conversionValue;
+ (NSString *)getPrecision9Str:(NSString *)amountStr Decimal:(int)Decimal;
+ (NSString *)getshuftiStr:(NSString *)conversionValue;
// 固定到8位精度，也可以去掉末尾多余的0
+ (NSString *)divideAndReturnPrecision8Str:(NSString *)nep5Str;
//乘以10^9以后，返回String
+ (NSString *)getONGMul10_9Str:(NSString *)ongStr;
+ (NSString *)getOEP4Str:(NSString *)amountStr Decimals:(int)Decimals;
+ (NSString *)changeOEP4Str:(NSString *)amountStr Decimals:(int)Decimals;
+ (NSString *)getOEP4ZeroStr:(NSString *)amountStr Decimals:(int)Decimals ;
+ (NSString *)getPayMoney:(NSString*)payMoney;
// GasLimit * gasPrice / 10^9
+ (NSString *)getRealFee:(NSString *)gasPrice GasLimit:(NSString *)gasLimit;

+ (NSString *)getAllFee:(NSString*)originalFee gasPrice:(NSString *)gasPrice GasLimit:(NSString *)gasLimit;
+ (BOOL)isEnoughOng:(NSString *)ong fee:(NSString *)fee;
// 判断未解绑ONG是否足够提取
+ (bool)isEnoughUnboundONG:(NSString *)unboundOng;

// 判断可声明ONG是否足够提取
+ (bool)isEnoughClaimableONG:(NSString *)claimableOng;

// 判断String是否是nil，@""，空白
+ (BOOL)isStringEmpty:(NSString *)text;

// 计算金钱
+ (NSString *)getMoney:(NSString *)amount Exchange:(NSString *)exchange;

//除以10^9以后，数字后面保留九位小数
+ (NSString *)divideAndReturnPrecision9Str:(NSString *)ongStr;

//把字符串转成Base64编码

+ (NSString *)base64EncodeString:(NSString *)string;
//字符串解码
+ (NSString *)stringEncodeBase64:(NSString *)base64;
//打乱数组顺序
+ (NSMutableArray *)getRandomArrFrome:(NSArray *)arr;

+ (NSString *)dislodgeNumericcharacte:(NSString *)string;


+ (NSString *)hexStringFromString:(NSString *)string;




@end
