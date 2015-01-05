//
//  TSGoodsRecommadDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSGoodsRecommandModel;

@interface TSGoodsRecommadDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSellNumber;


- (void)configureCellWithModel:(TSGoodsRecommandModel *)model indexPath:(NSIndexPath *)indexPath;
@end
