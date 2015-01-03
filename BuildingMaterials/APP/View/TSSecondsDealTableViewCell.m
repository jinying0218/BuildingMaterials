//
//  TSSecondsDealTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//


#import "TSSecondsDealTableViewCell.h"
#import "TSSecKillModel.h"
#import <UIImageView+WebCache.h>


@interface TSSecondsDealTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *secLabel;

@end
@implementation TSSecondsDealTableViewCell

- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)configureCellWithModelArray:(NSMutableArray *)models{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"cell_goodsExchange_bg"]];
    self.backgroundView.frame = CGRectMake( 0, 0, KscreenW, self.frame.size.height - 50);
    for (int i = 0; i < models.count; i++) {
        TSSecKillModel *model = models[i];
        switch (i) {
            case 0:{
                [self.fristGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.fristGoodsName.text = model.GOODS_NAME;
                self.fristGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                self.fristGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                self.fristGoodsPrice.strikeThroughEnabled = YES;
                
                [[TSDateFormatterTool shareInstance] setDateStyle:NSDateFormatterMediumStyle];
                [[TSDateFormatterTool shareInstance] setTimeStyle:NSDateFormatterShortStyle];
                [[TSDateFormatterTool shareInstance] setTimeZone:[NSTimeZone systemTimeZone]];
                [[TSDateFormatterTool shareInstance] setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSDate *date = [[TSDateFormatterTool shareInstance] dateFromString:model.END_TIME];
                
                NSTimeInterval endTimeInterval = [date timeIntervalSince1970];

                
                NSDate *datenow = [NSDate date];
                NSTimeInterval currentTimeInterval = [datenow timeIntervalSince1970];
                
                long miniTineInterval = currentTimeInterval - endTimeInterval;
                
                NSString *timeIn = [[TSDateFormatterTool shareInstance] IntervalStringFromDate:date];
                
                self.mzTimerLabel = [[MZTimerLabel alloc] initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
                [self.mzTimerLabel setCountDownTime:miniTineInterval];
                [self.mzTimerLabel start];

                
            }
                break;
                
            case 1:{
                [self.secondGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.secondGoodsName.text = model.GOODS_NAME;
                self.secondGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                self.secondGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                self.secondGoodsPrice.strikeThroughEnabled = YES;

            }
                break;
            case 2:{
                [self.thirdGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.thirdGoodsName.text = model.GOODS_NAME;
                self.thirdGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                self.thirdGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                self.thirdGoodsPrice.strikeThroughEnabled = YES;

            }
                break;
            default:
                break;
        }
    }
}
- (NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
}
@end
