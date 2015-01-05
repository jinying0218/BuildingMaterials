//
//  TSGoodsExchangeDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSExchangeModel;

@interface TSGoodsExchangeDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
@property (weak, nonatomic) IBOutlet UILabel *wantsGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *wantsNumber;




- (void)configureCellWithModel:(TSExchangeModel *)model indexPath:(NSIndexPath *)indexPath;

@end
