//
//  TSShopDetailCollectionViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/12/17.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopDetailCollectionViewCell.h"
#import "TSGoodsRecommandModel.h"
#import <UIImageView+WebCache.h>

static NSString *const cellIdentifier = @"TSShopDetailCollectionViewCell";
@implementation TSShopDetailCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    // 1.仅仅做一次cell的注册
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        UINib *nib = [UINib nibWithNibName:@"GVDonateCell" bundle:nil];
    //        [collectionView registerNib:nib forCellWithReuseIdentifier:@"donateCell"];
    //    });
    UINib *nib = [UINib nibWithNibName:@"TSShopDetailCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    
    // 2.从缓存池中取出cell
    return [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
}
- (void)configureCellWithModel:(TSGoodsRecommandModel *)goodsModel{
    if (![goodsModel.GOODS_HEAD_IMAGE isEqual:[NSNull null]]) {
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.GOODS_HEAD_IMAGE]];
    }
    self.goodsPrice.text = [NSString stringWithFormat:@"%d",goodsModel.GOODS_NEW_PRICE];
    self.goodsName.text = goodsModel.GOODS_NAME;
    
}
@end
