//
//  TSShopCarTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSShopCarCellSubviewModel.h"

typedef void(^TSGetCarInfo)(BOOL refreshCarMoney);

//@class TSShopCarModel;

@interface TSShopCarTableViewCell : UITableViewCell
@property (nonatomic, strong) TSShopCarCellSubviewModel *subviewModel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minutsButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsParameters;

@property (nonatomic, strong) TSGetCarInfo getCarInfo;
//- (void)configureCell:(TSShopCarModel *)model;
- (void)attachViewModel:(TSShopCarCellSubviewModel *)subviewModel carInfo:(TSGetCarInfo)getCarInfo;
@end
