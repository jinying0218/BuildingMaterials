//
//  TSShopCollectTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopCollectTableViewCell.h"
#import "TSCollectModel.h"
#import <UIImageView+WebCache.h>

@implementation TSShopCollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureShopCell:(TSCollectModel *)model{
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:model.goods_Head_ImageUrl] placeholderImage:[UIImage imageNamed:@"not_load"]];
    self.shopName.text = model.goodsName;
    self.shopDesc.text = model.goods_des_simple;
    self.price.text = [NSString stringWithFormat:@"%d",model.goods_new_price];
    
}
@end
