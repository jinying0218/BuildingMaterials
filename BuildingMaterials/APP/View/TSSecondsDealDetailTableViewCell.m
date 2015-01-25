//
//  TSSecondsDealDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/1.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondsDealDetailTableViewCell.h"
#import "TSSecKillModel.h"
#import <UIImageView+WebCache.h>

@implementation TSSecondsDealDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSSecKillModel *)model indexPath:(NSIndexPath *)indexPath{
    self.goodsName.text = model.GOODS_NAME;
    self.oldPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
    self.oldPrice.strikeThroughEnabled = YES;
    self.seckillPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
    self.seckillNumber.text = [NSString stringWithFormat:@"剩余%d",model.SECKILL_NUMBER_NOW];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE] placeholderImage:[UIImage imageNamed:@"not_load"]];
}
@end
