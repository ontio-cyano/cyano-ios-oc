//
//  GCModelConst.m
//  GCDatabase
//
//  Created by Faney on 16/1/26.
//  Copyright © 2016年 Faney. All rights reserved.
//

#ifndef _BaseMoelConst_M_
#define _BaseMoelConst_M_

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  字符串
 */
NSString *const CoreNSString = @"NSString";

/**
 *  NSInteger
 */
NSString *const CoreNSInteger = @"q,i";

/**
 *  NSUInteger
 */
NSString *const CoreNSUInteger = @"Q,I";

/**
 *  CGFloat
 */
NSString *const CoreCGFloat = @"d,f";

/**
 *  float
 */
NSString *const Corefloat = @"f";

/**
 *  double
 */
NSString *const Coredouble = @"d";

/**
 *  Enum、int
 */
NSString *const CoreEnum_int = @"i";

/**
 *  BOOL
 */
NSString *const CoreBOOL = @"B,c";

/**
 *  NSData
 */
NSString *const CoreNSData = @"NSData";

/**
 *  NSArray
 */
NSString *const CoreNSArray = @"NSArray";

/**
 *  NSDictionary
 */
NSString *const CoreNSDictionary = @"NSDictionary";

/**
 *  NSDate
 */
NSString *const CoreNSDate = @"NSDate";


/**
 *  SQL语句Const
 */

/**
 *  值是一个带符号的整数，根据值的大小存储在 1、2、3、4、6 或 8 字节中
 */
NSString *const INTEGER_TYPE = @"INTEGER";

/**
 *  值是一个文本字符串，使用数据库编码（UTF-8、UTF-16BE 或 UTF-16LE）存储
 */
NSString *const TEXT_TYPE = @"TEXT";

/**
 *  值是一个浮点值，存储为 8 字节的 IEEE 浮点数字
 */
NSString *const REAL_TYPE = @"REAL";

/**
 *  二进制，值是一个 blob 数据，完全根据它的输入存储
 */
NSString *const BLOB_TYPE = @"BLOB";

/**
 *  TIMESTAMP
 */
NSString *const TIMESTAMP_TYPE = @"TIMESTAMP";


#endif
