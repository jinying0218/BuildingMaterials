//
//  TSDateFormatter.h
//  ProInspection
//
//  Created by Aries on 14-7-16.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSDateFormatterTool : NSDateFormatter

SINGLETON_INTERFACE(TSDateFormatterTool);

- (NSString *)dateIntervalString;
- (NSString *)IntervalStringFromDate:(NSDate *)nowDate;
//yyyy年MM月dd日
- (NSDate *)dateFromTimeIntervalString:(NSString *)timeInterval;
@end
