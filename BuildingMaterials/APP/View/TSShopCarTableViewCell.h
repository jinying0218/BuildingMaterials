//
//  TSShopCarTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSShopCarModel;

@interface TSShopCarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsCount;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minutsButton;

- (void)configureCell:(TSShopCarModel *)model;
@end
