//
//  TSShopCarTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopCarTableViewCell.h"
#import "TSShopCarModel.h"
#import <UIImageView+WebCache.h>

@implementation TSShopCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(TSShopCarModel *)model{
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.goods_head_imageURL] placeholderImage:[UIImage imageNamed:@"not_load"]];
    self.goodsName.text = model.goodsName;
//    self.goodsCount.text =
    self.goodsPrice.text = [NSString stringWithFormat:@"￥%d",model.goods_price];
    
    
}
@end
