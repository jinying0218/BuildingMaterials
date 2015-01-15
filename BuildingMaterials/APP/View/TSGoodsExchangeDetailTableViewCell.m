//
//  TSGoodsExchangeDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsExchangeDetailTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "TSExchangeListModel.h"

@implementation TSGoodsExchangeDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSExchangeListModel *)model indexPath:(NSIndexPath *)indexPath{
    if (![model.THINGS_HEAD_IMAGE isEqual:[NSNull null]]) {
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.THINGS_HEAD_IMAGE] placeholderImage:[UIImage imageNamed:@"not_load"]];
    }
    self.goodsName.text = model.THINGS_NAME;
    self.goodsDes.text = model.THINGS_DES;
    self.wantsGoodsName.text = model.THINGS_WANTS;
}

@end
