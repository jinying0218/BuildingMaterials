//
//  TSCollectTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSCollectModel;
@interface TSGoodsCollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
- (void)configureGoodsCollectCell:(TSCollectModel *)model;
@end
