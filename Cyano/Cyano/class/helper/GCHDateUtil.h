//
//  GCHDateUtil.h
//  CUBE
//
//  Created by Faney on 16/4/28.
//  Copyright © 2016年 Faney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCHDateUtil : NSObject

/**
 *  获取日期
 *  In: 2017-12-09T12:38:50.977410
 *  Out: 2017-12-09
 */
+ (NSString *)getDate:(NSString *)dateStr;

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return (0时区改东八区)
 */
+ (NSString *)changeTimeZoneFromNormalZoneToLocalZone:(NSString *)dateStr;

/**
 *  get NSDate from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return (0时区NSDate)
 */
+ (NSDate *)getDateFromNormalZoneDateString:(NSString *)dateStr;

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return (东八区改0时区)
 */
+ (NSString *)changeTimeZoneFromLocalZoneToNormalZone:(NSString *)dateStr;

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return 19:48:37
 */
+ (NSString *)getTimeFromDateString:(NSString *)dateStr;

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-21
 *
 *  @return ["21", "Apr"]
 */
+ (NSArray *)getDayAndMonthFromDateString:(NSString *)dateStr;

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return 2016-04-25 17:14
 */
+ (NSString *)getDateAndTimeFromDateString:(NSString *)dateStr;

/**
 *  get default date and time
 *
 *  @return 1970-01-01T00:00:00Z
 */
+ (NSString *)getDefaultDate;

/**
 *  get real date and time
 *
 *  @return 1970-01-01T00:00:00Z
 */
+ (NSString *)getRealDate:(NSString *)dateStr;

/**
 *  get default date and time
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return 10秒
 */
+ (NSTimeInterval)getTimeIntervalFromNow:(NSString *)dateStr;

/**
 *  get now interval
 *
 *  @return time interval
 */
+ (NSTimeInterval)getTimeIntervalFromNow;

// 获取时间戳（以毫秒为单位）
+ (NSTimeInterval)getTimestampFromDate:(NSDate *)date;

// 获取当前时间戳（以毫秒为单位）
+ (long)getNowTimeTimestamp;

/**
 *  get string from server time
 *  @param serverTime 1534765500198
 *  @return 2018年8月20日 16:00
 */
+ (NSString *)getStringFromServerTime:(unsigned long long)serverTime;

/**
 *  get format time
 *  @param dateTime 2018-11-21T13:26:44.000Z
 *  @return 今天/明天/7月2日 13:26
 */
+ (NSString *)formatCompactDateTime:(NSString *)dateTime;

/**
 *  get age from server time
 *  @param dateTime 2016-05-21
 *  @return 3.5岁
 */
+ (NSString *)getAgeFromServerTime:(NSString *)dateTime;

/**
 *  get time string from seconds
 *  @param seconds 93662
 *  @return 1天2小时1分2秒结束
 */
+ (NSString *)getTimeStringFromSeconds:(long long)seconds;

@end
