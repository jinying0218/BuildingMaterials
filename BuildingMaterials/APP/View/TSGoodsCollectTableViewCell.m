//
//  TSCollectTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsCollectTableViewCell.h"
#import "TSCollectModel.h"
#import <UIImageView+WebCache.h>

@implementation TSGoodsCollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureGoodsCollectCell:(TSCollectModel *)model{
    self.goodsDes.text = model.goods_des_simple;
    self.goodsName.text =model.goodsName;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.goods_Head_ImageUrl] placeholderImage:[UIImage imageNamed:@"not_load"]];
}
@end
