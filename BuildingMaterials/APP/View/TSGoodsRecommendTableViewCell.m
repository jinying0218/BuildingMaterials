//
//  TSGoodsRecommendTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsRecommendTableViewCell.h"
#import "TSGoodsRecommandModel.h"
#import <UIImageView+WebCache.h>

@implementation TSGoodsRecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModelArray:(NSMutableArray *)models{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"cell_goodsExchange_bg"]];
    self.backgroundView.frame = CGRectMake( 0, 0, KscreenW, self.frame.size.height - 50);
    for (int i = 0; i < models.count; i++) {
        TSGoodsRecommandModel *model = models[i];
        switch (i) {
            case 0:{
                [self.firstGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.firstGoodsName.text = model.GOODS_NAME;
                self.firstGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                //                self.fristGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
                //                self.fristGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
                //                self.fristGoodsPrice.strikeThroughEnabled = YES;
                
                
            }
                break;
                
            case 1:{
                [self.secondGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.secondGoddsName.text = model.GOODS_NAME;
                self.secondGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];

                //                self.secondGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
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
