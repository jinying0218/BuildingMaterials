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
#import <BlocksKit+UIKit.h>

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
    self.goodsPrice.text = [NSString stringWithFormat:@"￥%d",model.goods_price];
    self.goodsCount.text = [NSString stringWithFormat:@"%d",self.subviewModel.goodsCount];
    self.goodsParameters.text = model.parameters;
    if (self.subviewModel.inShopCar) {
        self.selectButton.selected = YES;
    }else {
        self.selectButton.selected = NO;
    }
}
- (void)attachViewModel:(TSShopCarCellSubviewModel *)subviewModel carInfo:(TSGetCarInfo)getCarInfo{
    [self.KVOController unobserve:self.subviewModel];
    self.getCarInfo = getCarInfo;
    self.subviewModel = subviewModel;
    [self configureCell:subviewModel.shopCarModel];
    [self blindViewModel];
    [self blindActionHandler];
}
- (void)blindViewModel{
    [self.KVOController
     observe:self.subviewModel
     keyPath:@keypath(self.subviewModel,goodsCount)
     options:NSKeyValueObservingOptionNew
     block:^(TSShopCarTableViewCell *observer, TSShopCarCellSubviewModel *object, NSDictionary *change) {
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             int goodsCount = [change[NSKeyValueChangeNewKey] intValue];
             //  修改当前物品的总价钱
             [object setGoodsTotalMoney:(goodsCount * object.shopCarModel.goods_price)];
             [observer.goodsCount setText:[NSString stringWithFormat:@"%d",goodsCount]];
         }
    }];
    
    [self.KVOController
     observe:self.subviewModel
     keyPath:@keypath(self.subviewModel,goodsTotalMoney)
     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
     block:^(TSShopCarTableViewCell *observer, TSShopCarCellSubviewModel *object, NSDictionary *change) {
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             if (object.inShopCar) {
                 float oldGoodsTotalMoney = [change[NSKeyValueChangeOldKey] floatValue];
                 float currentGoodsTotalMoney = [change[NSKeyValueChangeNewKey] floatValue];
                 //  修改购物车的总价钱
                 float shopCarTotalMoney = object.shopCarMoney.money - oldGoodsTotalMoney + currentGoodsTotalMoney;
                 [object.shopCarMoney setMoney:shopCarTotalMoney];
             }
         }
     }];
    
    [self.KVOController
     observe:self.subviewModel
     keyPath:@keypath(self.subviewModel,inShopCar)
     options:NSKeyValueObservingOptionNew
     block:^(TSShopCarTableViewCell *observer, TSShopCarCellSubviewModel *object, NSDictionary *change) {
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             
//             [object.shopCarMoney setMoney:shopCarTotalMoney];
         }
     }];



}
- (void)blindActionHandler{
    @weakify(self);
    [self.minutsButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.subviewModel.goodsCount > 1) {
            int goodsCount = self.subviewModel.goodsCount - 1;
            [self.subviewModel setGoodsCount:goodsCount];
        }
    } forControlEvents:UIControlEventTouchUpInside];
 
    [self.plusButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.subviewModel.goodsCount < 20) {
            int goodsCount = self.subviewModel.goodsCount + 1;
            [self.subviewModel setGoodsCount:goodsCount];
        }

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.selectButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectButton.selected = !self.selectButton.selected;
        if (self.selectButton.selected) {
            [self.subviewModel setInShopCar:YES];
        }else {
            [self.subviewModel setInShopCar:NO];
        }
        self.getCarInfo(YES);
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
