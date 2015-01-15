//
//  TSCategoryCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCategoryCell.h"
#import "TSCategoryModel.h"
#import <UIImageView+WebCache.h>

@implementation TSCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSCategoryModel *)model{
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.classifyImageUrl] placeholderImage:[UIImage imageNamed:@"not_load"]];
    self.categoryName.text = model.classifyName;
    self.categoryDetail.text = model.classifyDes;
}
@end
