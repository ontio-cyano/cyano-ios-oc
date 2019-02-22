//
//  GCHDateUtil.m
//  CUBE
//
//  Created by Faney on 16/4/28.
//  Copyright © 2016年 Faney. All rights reserved.
//  日期、时间工具

#import "GCHDateUtil.h"

@implementation GCHDateUtil

/**
 *  获取日期
 *  In: 2017-12-09T12:38:50.977410
 *  Out: 2017-12-09
 */
+ (NSString *)getDate:(NSString *)dateStr
{
    NSArray *dateArr = [dateStr componentsSeparatedByString:@"T"];
    if (dateArr.count > 0) return dateArr[0];
    return dateStr;
}

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return (0时区改东八区)
 */
+ (NSString *)changeTimeZoneFromNormalZoneToLocalZone:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeZone *timeSystemZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeSystemZone];
    return [dateFormatter stringFromDate:date];
}

/**
 *  get NSDate from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return (0时区NSDate)
 */
+ (NSDate *)getDateFromNormalZoneDateString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return [dateFormatter dateFromString:dateStr];
}

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return (东八区改0时区)
 */
+ (NSString *)changeTimeZoneFromLocalZoneToNormalZone:(NSString *)dateStr;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSTimeZone *timeSystemZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeSystemZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
    [dateFormatter setTimeZone:timeZone];
    return [dateFormatter stringFromDate:date];
}

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return 01:55:32
 */
+ (NSString *)getTimeFromDateString:(NSString *)dateStr
{
    NSArray *dateArr = [dateStr componentsSeparatedByString:@"T"];
    if (dateArr.count != 2) return @"";
    dateArr = [[dateArr lastObject] componentsSeparatedByString:@"Z"];
    if (dateArr.count != 2) return @"";
    return [dateArr objectAtIndex:0];
}

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-21
 *
 *  @return ["4", "Apr"]
 */
+ (NSArray *)getDayAndMonthFromDateString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    if (!date) return nil;
    
    // 英文月份
    [dateFormatter setDateFormat:@"d-MMM"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *newDateStr = [dateFormatter stringFromDate:date];
    return [newDateStr componentsSeparatedByString:@"-"];
}

/**
 *  get date and time from a dateStr
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return 2016-04-25 17:14
 */
+ (NSString *)getDateAndTimeFromDateString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSTimeZone *timeSystemZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeSystemZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}

/**
 *  get default date and time
 *
 *  @return 1970-01-01T00:00:00Z
 */
+ (NSString *)getDefaultDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
    [dateFormat setTimeZone:timeZone];
    
    // NSDate *agoDate = [NSDate dateWithTimeIntervalSince1970:0];
    // NSString *ago = [dateFormat stringFromDate:agoDate];
    
    NSString *now = [dateFormat stringFromDate:[NSDate date]];
    return now;
}

/**
 *  get real date and time
 *
 *  @return 1970-01-01T00:00:00Z
 */
+ (NSString *)getRealDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
    [dateFormat setTimeZone:timeZone];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    return [dateFormat stringFromDate:date];
}

/**
 *  get default date and time
 *
 *  @param dateStr eg:2016-04-26T01:55:32Z
 *
 *  @return 10秒
 */
+ (NSTimeInterval)getTimeIntervalFromNow:(NSString *)dateStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
    [dateFormat setTimeZone:timeZone];
    
    // Check
    NSDate *checkDate = [dateFormat dateFromString:dateStr];
    return [[NSDate date] timeIntervalSinceDate:checkDate];
}

/**
 *  get now interval
 *
 *  @return time interval
 */
+ (NSTimeInterval)getTimeIntervalFromNow
{
    NSDate *checkDate = [NSDate date];
    return [[NSDate date] timeIntervalSinceDate:checkDate];
}

// 获取时间戳（以毫秒为单位）
+ (NSTimeInterval)getTimestampFromDate:(NSDate *)date
{
    return [date timeIntervalSince1970] * 1000;
}

// 获取当前时间戳（以毫秒为单位）
+ (long)getNowTimeTimestamp
{
    NSDate *datenow = [NSDate date];
    return (long)[self getTimestampFromDate:datenow];
}

/**
 *  get string from server time
 *  @param serverTime 1534765500198
 *  @return 2018年8月20日 16:00
 */
+ (NSString *)getStringFromServerTime:(unsigned long long)serverTime
{
    if (serverTime == 0) return @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(serverTime / 1000.0)];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSString *format = @"yyyy年MM月dd日&HH:mm";
    [dateFormat setDateFormat:format];
    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *dateStr = [date stringWithFormat:format];
    NSArray *dateArr = [dateStr componentsSeparatedByString:@"&"];
    if (dateArr.count != 2) return @"";
    return [NSString stringWithFormat:@"%@ %@", [self formatCompactDateTime:dateArr[0]], dateArr[1]];
}

/**
 *  get format time
 *  @param dateTime 2018-11-21T13:26:44.000Z
 *  @return 今天/明天/7月2日 13:26
 */
+ (NSString *)formatCompactDateTime:(NSString *)dateTime
{
    dateTime = [self changeTimeZoneFromNormalZoneToLocalZone:dateTime];
    NSArray *dateArr = [dateTime componentsSeparatedByString:@"T"];
    if (dateArr.count != 2) return dateTime;
    NSString *monthDay = dateArr[0];
    
    dateArr = [dateArr[1] componentsSeparatedByString:@":"];
    if (dateArr.count != 3) return dateTime;
    NSString *time = [NSString stringWithFormat:@"%02d:%02d", [dateArr[0] intValue], [dateArr[1] intValue]];
    
    dateArr = [monthDay componentsSeparatedByString:@"-"];
    if (dateArr.count != 3) return monthDay;
    int year = [dateArr[0] intValue];
    int month = [dateArr[1] intValue];
    int day = [dateArr[2] intValue];
    
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    // 今天
    NSDate *dateNow = [NSDate date];
    NSDateComponents *componentsToday = [calendar components:flags fromDate:dateNow];
    NSDate *dateNowZero = [calendar dateFromComponents:componentsToday];
    
    // 传入时间
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [calendar dateFromComponents:components];

    if (month == componentsToday.month && day == componentsToday.day)
        return [NSString stringWithFormat:@"今天 %@", time];
    if ([date timeIntervalSinceDate:dateNowZero] == 24 * 60 * 60)
        return [NSString stringWithFormat:@"明天 %@", time];
    if ([date timeIntervalSinceDate:dateNowZero] == -24 * 60 * 60)
        return [NSString stringWithFormat:@"昨天 %@", time];
    
    // 上周或下周
    float betweenDaysFloat = (dateNow.timeIntervalSince1970 - date.timeIntervalSince1970) / (24 * 60 * 60);
    int betweenDays = (int)betweenDaysFloat;
    if (betweenDays < 0 && betweenDaysFloat != betweenDays) betweenDays = betweenDays - 1;
    if (fabs((float)betweenDays) < 7 + (betweenDays < 0 ? (7 - (componentsToday.weekday - 1) + 1) : (componentsToday.weekday - 1)))
    {
        NSArray *weekdays = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
        NSInteger indexToday = componentsToday.weekday - 1;
        NSString *prefix = @"本";
        NSInteger index = indexToday - betweenDays;
        if (index <= 0) prefix = @"上";
        if (index >= 8) prefix = @"下";
        if (index < 0) index = weekdays.count + index;
        if (index >= 7) index = index % weekdays.count;
        return [NSString stringWithFormat:@"%@%@ %@", prefix, weekdays[index], time];
    }
    
    return [NSString stringWithFormat:@"%02d月%02d日 %@", month, day, time];
}

/**
 *  get age from server time
 *  @param dateTime 2016-05-21
 *  @return 3.5岁
 */
+ (NSString *)getAgeFromServerTime:(NSString *)dateTime
{
    NSArray *dateArr = [dateTime componentsSeparatedByString:@"-"];
    if (dateArr.count != 3) return dateTime;
    int year = [dateArr[0] intValue];
    int month = [dateArr[1] intValue];
    int day = [dateArr[2] intValue];
    
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    // 今天
    NSDate *dateNow = [NSDate date];
    NSDateComponents *componentsToday = [calendar components:flags fromDate:dateNow];
    NSDate *dateNowZero = [calendar dateFromComponents:componentsToday];
    
    // 传入时间
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [calendar dateFromComponents:components];
    
    NSInteger oneYearTimeInterval = 24 * 60 * 60 * 365;
    NSInteger oneMonthTimeInterval = 24 * 60 * 60 * 30;
    
    NSTimeInterval intervalSinceNow = [dateNowZero timeIntervalSinceDate:date];
    int overOneYearInterval = (int)intervalSinceNow % oneYearTimeInterval;
    int ageYears = intervalSinceNow / oneYearTimeInterval;
    
    float ageDecimal = 0.0f;
    if (overOneYearInterval < oneMonthTimeInterval * 3) ageDecimal = 0.0f;
    else if (overOneYearInterval < oneMonthTimeInterval * 9) ageDecimal = 0.5f;
    else ageDecimal = 1.0f;
    
    if (ageDecimal == 0.0f || ageDecimal == 1.0f)
        return [NSString stringWithFormat:@"%d岁", ageYears + (int)ageDecimal];
    else
        return [NSString stringWithFormat:@"%.1f岁", ageYears + ageDecimal];
}

/**
 *  get time string from seconds
 *  @param seconds 93662
 *  @return 1天2小时1分2秒结束
 */
+ (NSString *)getTimeStringFromSeconds:(long long)seconds
{
    long long msec = seconds;
    if (msec <= 0)
    {
        return @"已结束";
    }
    
    NSInteger d = msec / 60 / 60 / 24;
    NSInteger h = msec / 60 / 60 % 24;
    NSInteger m = msec / 60 % 60;
    NSInteger s = msec % 60;
    
    NSString *dStr = d > 0 ? [NSString stringWithFormat:@"%ld天", d] : @"";
    NSString *hStr = h > 0 ? [NSString stringWithFormat:@"%ld小时", h] : @"";
    NSString *mStr = m > 0 ? [NSString stringWithFormat:@"%ld分", m] : @"";
    NSString *sStr = s > 0 ? [NSString stringWithFormat:@"%ld秒", s] : @"";
    
    return [NSString stringWithFormat:@"%@%@%@%@结束", dStr, hStr, mStr, sStr];
}

@end
