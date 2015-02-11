//
//  TSShopRecommedDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSShopModel;

@interface TSShopRecommedDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopDes;
@property (weak, nonatomic) IBOutlet UILabel *shopGoodsNumber;


- (void)configureCellWithModel:(TSShopModel *)model indexPath:(NSIndexPath *)indexPath;

@end
