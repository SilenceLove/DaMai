//
//  NSDate+Extension.m
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (BOOL)isCurrentDate:(NSString *)date
{
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:date];
    NSTimeInterval interval = [[self date] timeIntervalSinceDate:timeDate];
    if (interval < 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[self date]];
    return dateTime;
}

+ (NSString *)getTomorrowDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[self date]];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (NSString *)getWeekDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*7 sinceDate:[NSDate date]];
    NSString *dateTime = [formatter stringFromDate:nextDate];
    return dateTime;
}

+ (NSString *)getAfterTomorrowDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*2 sinceDate:[NSDate date]];
    NSString *dateTime = [formatter stringFromDate:nextDate];
    return dateTime;
}

+ (NSString *)getMonthDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*30 sinceDate:[NSDate date]];
    NSString *dateTime = [formatter stringFromDate:nextDate];
    return dateTime;
}

@end
