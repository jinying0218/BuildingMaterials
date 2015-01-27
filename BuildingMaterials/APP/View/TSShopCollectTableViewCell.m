//
//  TSShopCollectTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopCollectTableViewCell.h"
#import "TSCollectionShopModel.h"
#import <UIImageView+WebCache.h>

@implementation TSShopCollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureShopCell:(TSCollectionShopModel *)model{
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:model.collectionCompanyImageURL] placeholderImage:[UIImage imageNamed:@"not_load"]];
    self.shopName.text = model.collectionCompanyName;
    self.shopDesc.text = model.collectionCompanyDes;
}
@end
