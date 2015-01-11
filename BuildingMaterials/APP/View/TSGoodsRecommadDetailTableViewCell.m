//
//  TSGoodsRecommadDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsRecommadDetailTableViewCell.h"
#import "TSGoodsRecommandModel.h"
#import <UIImageView+WebCache.h>

@implementation TSGoodsRecommadDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSGoodsRecommandModel *)model indexPath:(NSIndexPath *)indexPath{
    if (![model.GOODS_HEAD_IMAGE isEqual:[NSNull null]]) {
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE]];
    }
    self.goodsName.text = model.GOODS_NAME;
    self.goodsDes.text = model.GOODS_DES_SIMPLE;
    self.goodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
    self.goodsSellNumber.text = [NSString stringWithFormat:@"%d人购买",model.GOODS_SELL_NUMBER];
}
@end
