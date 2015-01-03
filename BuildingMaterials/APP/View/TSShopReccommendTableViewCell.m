//
//  TSShopReccommendTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopReccommendTableViewCell.h"
#import "TSShopModel.h"
#import <UIImageView+WebCache.h>

@implementation TSShopReccommendTableViewCell

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
        TSShopModel *model = models[i];
        switch (i) {
            case 0:{
                [self.fristShopImage sd_setImageWithURL:[NSURL URLWithString:model.COMPANY_IMAGE_URL]];
                self.firstShopName.text = model.COMPANY_NAME;
//                self.fristGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
//                self.fristGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
//                self.fristGoodsPrice.strikeThroughEnabled = YES;
                
                
            }
                break;
                
            case 1:{
                [self.secondShopImage sd_setImageWithURL:[NSURL URLWithString:model.COMPANY_IMAGE_URL]];
                self.secondShopName.text = model.COMPANY_NAME;
//                self.secondGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
//                self.secondGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
//                self.secondGoodsPrice.strikeThroughEnabled = YES;
                
            }
                break;
            case 2:{
                [self.thirdShopImage sd_setImageWithURL:[NSURL URLWithString:model.COMPANY_IMAGE_URL]];
                self.thirdShopName.text = model.COMPANY_NAME;
//                self.thirdGoodsNowPrice.text = [NSString stringWithFormat:@"%d",model.SECKILL_PRICE];
//                self.thirdGoodsPrice.text = [NSString stringWithFormat:@"%d",model.GOODS_NEW_PRICE];
//                self.thirdGoodsPrice.strikeThroughEnabled = YES;
                
            }
                break;
            default:
                break;
        }
    }

}
@end
