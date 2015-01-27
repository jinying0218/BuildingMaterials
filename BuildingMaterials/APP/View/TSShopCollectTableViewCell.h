//
//  TSShopCollectTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSCollectionShopModel;

@interface TSShopCollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopDesc;
@property (weak, nonatomic) IBOutlet UILabel *price;

- (void)configureShopCell:(TSCollectionShopModel *)model;
@end
