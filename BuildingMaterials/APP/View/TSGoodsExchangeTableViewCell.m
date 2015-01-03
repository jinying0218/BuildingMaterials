//
//  TSGoodsExchangeTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsExchangeTableViewCell.h"
#import "TSExchangeModel.h"
#import <UIImageView+WebCache.h>

@implementation TSGoodsExchangeTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
- (void)configureCellWithModelArray:(NSMutableArray *)models{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"cell_goodsExchange_bg"]];
    self.backgroundView.frame = CGRectMake( 0, 0, KscreenW, self.frame.size.height - 50);
    for (int i = 0; i < models.count; i++) {
        TSExchangeModel *model = models[i];
        switch (i) {
            case 0:{
                [self.firstExchangeGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.THINGS_HEAD_IMAGE]];
                self.firstChangeGoodsName.text = model.THINGS_NAME;
                self.firstWantGoodsName.text = model.THINGS_WANTS;
                //                self.fristGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                //                self.fristGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                //                self.fristGoodsPrice.strikeThroughEnabled = YES;
                
                
            }
                break;
                
            case 1:{
                [self.secondExchangeGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.THINGS_HEAD_IMAGE]];
                self.secondChangeGoodsName.text = model.THINGS_NAME;
                self.secondWantGoodsName.text = model.THINGS_WANTS;
                //                self.secondGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                //                self.secondGoodsPrice.strikeThroughEnabled = YES;
                
            }
                break;
            default:
                break;
        }
    }


}
@end
