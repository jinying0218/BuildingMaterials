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
                self.fristGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
            }
                break;
                
            case 2:{
                [self.secondGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.secondGoodsName.text = model.GOODS_NAME;
                self.secondGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
            }
                break;
            case 3:{
                [self.thirdGoodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
                self.thirdGoodsName.text = model.GOODS_NAME;
                self.thirdGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
            }
                break;
            default:
                break;
        }
    }
}

@end
