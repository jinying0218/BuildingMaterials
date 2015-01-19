//
//  ClockView.h
//  ClockDemo
//
//  Created by iOS on 15/1/4.
//  Copyright (c) 2015年 com.haitaolvyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ClockStyle){
    ClockStyleDefault,
    ClockStyleRed,
};
@interface ClockView : UIView

- (id)initWithFrame:(CGRect)frame style:(ClockStyle)style;

//设置时间,开始计时
- (void)setWithEndTime:(NSString *)endTime;

@property (nonatomic,strong) void(^Activate)(void);         //倒计时为0时

@end
