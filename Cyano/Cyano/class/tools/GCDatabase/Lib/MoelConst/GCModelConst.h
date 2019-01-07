//
//  GCModelConst.h
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#ifndef _BaseMoelConst_H_
#define _BaseMoelConst_H_
#define NSArrayNorlMalTypes @[@"NSString", @"NSData"]

/**
 *  NSString
 */
UIKIT_EXTERN NSString *const CoreNSString;

/**
 *  NSInteger
 */
UIKIT_EXTERN NSString *const CoreNSInteger;

/**
 *  NSUInteger
 */
UIKIT_EXTERN NSString *const CoreNSUInteger;

/**
 *  CGFloat
 */
UIKIT_EXTERN NSString *const CoreCGFloat;

/**
 *  Enum、int
 */
UIKIT_EXTERN NSString *const CoreEnum_int;

/**
 *  BOOL:BOOL类型的变量对应sqlite中的integer方便扩展
 */
UIKIT_EXTERN NSString *const CoreBOOL;

/**
 *  NSData
 */
UIKIT_EXTERN NSString *const CoreNSData;

/**
 *  NSArray
 */
UIKIT_EXTERN NSString *const CoreNSArray;

/**
 *  NSDictionary
 */
UIKIT_EXTERN NSString *const CoreNSDictionary;

/**
 *  NSDate
 */
UIKIT_EXTERN NSString *const CoreNSDate;


/**
 *  SQL语句Const
 */

/**
 *  值是一个带符号的整数，根据值的大小存储在 1、2、3、4、6 或 8 字节中
 */
UIKIT_EXTERN NSString *const INTEGER_TYPE;

/**
 *  值是一个文本字符串，使用数据库编码（UTF-8、UTF-16BE 或 UTF-16LE）存储
 */
UIKIT_EXTERN NSString *const TEXT_TYPE;

/**
 *  值是一个浮点值，存储为 8 字节的 IEEE 浮点数字
 */
UIKIT_EXTERN NSString *const REAL_TYPE;

/**
 *  二进制，值是一个 blob 数据，完全根据它的输入存储
 */
UIKIT_EXTERN NSString *const BLOB_TYPE;

/**
 *  TIMESTAMP
 */
UIKIT_EXTERN NSString *const TIMESTAMP_TYPE;


#endif
