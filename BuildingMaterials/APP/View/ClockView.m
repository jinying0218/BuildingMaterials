//
//  ClockView.m
//  ClockDemo
//
//  Created by iOS on 15/1/4.
//  Copyright (c) 2015年 com.haitaolvyou. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView
{
    NSTimer *clockTimer;
    NSDate *endDate;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame style:(ClockStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat w = (frame.size.width-14)/11 ;     //根据 frame 设置每个 label 宽度
        for (int i = 0; i < 11; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2+(w+2)*i, 0, w, frame.size.height)];
            label.layer.cornerRadius = 2.0f;
            label.textColor = [UIColor whiteColor];
            label.tag = 20000+i;
            label.font = [UIFont boldSystemFontOfSize:16];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            NSLog(@"倒计时：%d",i);

            if (i == 2 || i == 5 || i == 8) {
                label.text = @":";
                label.textColor = [UIColor blackColor];
            }else{
                label.text = @"0";
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:label.frame];
                imgView.image = [UIImage imageNamed:@"time_bg.png"];
                [self insertSubview:imgView belowSubview:label];
            }
        }

    }
    return self;
}
- (void)setWithEndTime:(NSString *)endTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:zone];
    NSDate *date = [dateFormatter dateFromString:endTime];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    endDate = [date  dateByAddingTimeInterval: interval];
    
    clockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeRunning) userInfo:nil repeats:YES];
    [clockTimer fire];
}

- (void)timeRunning{
    //  手机当前时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *now = [date dateByAddingTimeInterval:interval];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:now];
    if (timeInterval > 0) {
        int hour = timeInterval/3600;//总小时数可能超过一天
        int d = hour/24;
        int minutes = (timeInterval-hour*3600)/60;
        int s = (int)(timeInterval-hour*3600)%60;
        int h = hour-d*24;
        [self setBasicAndTensPlaceNumberOfNumber:d tag:0];
        [self setBasicAndTensPlaceNumberOfNumber:h tag:1];
        [self setBasicAndTensPlaceNumberOfNumber:minutes tag:2];
        [self setBasicAndTensPlaceNumberOfNumber:s tag:3];
    }else{
        if (self.Activate) {
            self.Activate();
        }
        
        [clockTimer invalidate];
    }
    //    小时：h=time/3600（整除）
    //    分钟：m=(time-h*3600)/60 （整除）
    //    秒：s=(time-h*3600)%60 （取余）
}
- (void)setBasicAndTensPlaceNumberOfNumber:(int)number tag:(int)t{
    int tp = number/10;
    int basic = number%10;
    NSString *tensPlace = [NSString stringWithFormat:@"%d",tp];
    NSString *basciUnit = [NSString stringWithFormat:@"%d",basic];
    UILabel *label1 = (UILabel*)[self viewWithTag:20000+t*3];
    UILabel *label2 = (UILabel*)[self viewWithTag:20000+t*3+1];
    label1.text = tensPlace;
    label2.text = basciUnit;
    
}

@end
