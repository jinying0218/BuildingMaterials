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
    self.seckillPrice.text = [NSString stringWithFormat:@"￥%.2f",model.SECKILL_PRICE];
    if (model.SECKILL_NUMBER - model.SECKILL_NUMBER_NOW > 0) {
        self.seckillNumber.text = [NSString stringWithFormat:@"剩余%d",model.SECKILL_NUMBER - model.SECKILL_NUMBER_NOW];
    }else {
        self.seckillNumber.text = @"剩余0";
        model.haveOver = YES;
    }
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.GOODS_HEAD_IMAGE] placeholderImage:[UIImage imageNamed:@"not_load"]];
    
    self.goodsName.text = model.GOODS_NAME;
    self.oldPrice.text = [NSString stringWithFormat:@"￥%.2f",model.GOODS_NEW_PRICE];
    self.oldPrice.strikeThroughEnabled = YES;
    
    CGSize fitLabelSize = CGSizeMake( MAXFLOAT, 20);
    CGSize labelSize = [self.seckillPrice.text sizeWithFont:self.seckillPrice.font constrainedToSize:fitLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    self.seckillPrice.frame = CGRectMake( CGRectGetMaxX(self.goodsImage.frame) + 10,  CGRectGetMaxY(self.goodsName.frame) + 5, labelSize.width, 20);
    
    self.oldPrice.frame = CGRectMake( CGRectGetMaxX(self.seckillPrice.frame), CGRectGetMinY(self.seckillPrice.frame), 50, 20);
    
    self.goodsDesc.text = model.GOODS_DES;
    CGFloat itemDescWidth = self.goodsDesc.frame.size.width;
    CGFloat descHeight = [self.goodsDesc.text boundingRectWithSize:
                          CGSizeMake(itemDescWidth - 10, 36)
                                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.goodsDesc.font,NSFontAttributeName, nil] context:nil].size.height;
    self.goodsDesc.bounds = CGRectMake( 0, 0, itemDescWidth, descHeight);

}
@end
