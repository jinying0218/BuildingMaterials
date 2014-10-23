//
//  TSDateFormatter.m
//  ProInspection
//
//  Created by Aries on 14-7-16.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSDateFormatterTool.h"

@implementation TSDateFormatterTool

SYNTHESIZE_SINGLETON_FOR_CLASS(TSDateFormatterTool);

//获取当前时间的时间戳
- (NSString *)dateIntervalString
{
    NSDate *datenow = [NSDate date];
    NSTimeInterval timeInterval = [datenow timeIntervalSince1970] * 1000;
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)timeInterval];
    
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值

    return timeSp;
}

//根据时间生成时间戳
- (NSString *)IntervalStringFromDate:(NSDate *)nowDate
{
    NSTimeInterval timeInterval = [nowDate timeIntervalSince1970] * 1000;
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)timeInterval];

    return timeSp;
}
//跟据时间戳生成时间 字符串
- (NSDate *)dateFromTimeIntervalString:(NSString *)timeInterval
{
    [[TSDateFormatterTool sharedTSDateFormatterTool] setDateStyle:NSDateFormatterMediumStyle];
    [[TSDateFormatterTool sharedTSDateFormatterTool] setTimeStyle:NSDateFormatterShortStyle];
    [[TSDateFormatterTool sharedTSDateFormatterTool] setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [[TSDateFormatterTool sharedTSDateFormatterTool] setDateFormat:@"yyyy年MM月dd日"];
    
    NSTimeInterval time = [timeInterval longLongValue];
    NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:pastDate];
    NSDate *date = [pastDate dateByAddingTimeInterval:interval];
    
//    NSLog(@"date1:%@",date);
    
    return date;
}
@end
