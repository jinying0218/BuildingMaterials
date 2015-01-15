//
//  TSShopRecommedDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopRecommedDetailTableViewCell.h"
#import "TSShopModel.h"
#import <UIImageView+WebCache.h>

@implementation TSShopRecommedDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSShopModel *)model indexPath:(NSIndexPath *)indexPath{
    if (![model.COMPANY_IMAGE_URL isEqual:[NSNull null]]) {
        [self.shopImage sd_setImageWithURL:[NSURL URLWithString:model.COMPANY_IMAGE_URL] placeholderImage:[UIImage imageNamed:@"not_load"]];
    }
    self.shopName.text = model.COMPANY_NAME;
    self.shopDes.text = model.COMPANY_DES;
    
    if (model.IS_RECOMMEND) {
        self.recommendBtn.hidden = NO;
        self.recommendBtn.frame = CGRectMake( CGRectGetMaxX(self.shopName.frame), CGRectGetMinY(self.shopName.frame), 20, 20);
    }
    
}
@end
