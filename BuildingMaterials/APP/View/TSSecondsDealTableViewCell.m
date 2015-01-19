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
                [self.fristGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE] placeholderImage:[UIImage imageNamed:@"not_load"]];
                self.fristGoodsName.text = model.GOODS_NAME;
                self.fristGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                self.fristGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                self.fristGoodsPrice.strikeThroughEnabled = YES;
                
                self.endTimeView = [[ClockView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(self.secondsDealLabel.frame) + 10, 10, 100, 20) style:ClockStyleDefault];
                [self addSubview:self.endTimeView];
                [self.endTimeView setWithEndTime:model.END_TIME];
                
//                NSLog(@"%@",[self returnUploadTime:model.END_TIME]);
                
                [[TSDateFormatterTool shareInstance] setDateStyle:NSDateFormatterMediumStyle];
                [[TSDateFormatterTool shareInstance] setTimeStyle:NSDateFormatterShortStyle];
                [[TSDateFormatterTool shareInstance] setTimeZone:[NSTimeZone systemTimeZone]];
                [[TSDateFormatterTool shareInstance] setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
//                NSDate *date = [[TSDateFormatterTool shareInstance] dateFromString:model.END_TIME];
                
//                NSTimeInterval endTimeInterval = [date timeIntervalSince1970];
                
                
//                NSDate *datenow = [NSDate date];
//                NSTimeInterval currentTimeInterval = [datenow timeIntervalSince1970];
                
//                long miniTineInterval = currentTimeInterval - endTimeInterval;
                
//                NSString *timeIn = [[TSDateFormatterTool shareInstance] IntervalStringFromDate:date];
                
//                self.mzTimerLabel = [[MZTimerLabel alloc] initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
//                [self.mzTimerLabel setCountDownTime:miniTineInterval];
//                [self.mzTimerLabel start];
            }
                break;
                
            case 1:{
                [self.secondGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE] placeholderImage:[UIImage imageNamed:@"not_load"]];
                self.secondGoodsName.text = model.GOODS_NAME;
                self.secondGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                self.secondGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                self.secondGoodsPrice.strikeThroughEnabled = YES;

            }
                break;
            case 2:{
                [self.thirdGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE] placeholderImage:[UIImage imageNamed:@"not_load"]];
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

- (IBAction)touchCellImageView:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(touchCellImageView:)]) {
        [self.delegate touchCellImageView:button];
    }
}

@end
