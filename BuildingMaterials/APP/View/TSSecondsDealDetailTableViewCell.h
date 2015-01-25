//
//  TSSecondsDealDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/11/1.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPLabel.h"
@class TSSecKillModel;

@interface TSSecondsDealDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *seckillPrice;
@property (weak, nonatomic) IBOutlet LPLabel *oldPrice;

@property (weak, nonatomic) IBOutlet UIButton *discountPercent;
@property (weak, nonatomic) IBOutlet UIImageView *secondsDealNumber;
@property (weak, nonatomic) IBOutlet UILabel *seckillNumber;
@property (weak, nonatomic) IBOutlet UIButton *secondsBuyButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

- (void)configureCellWithModel:(TSSecKillModel *)model indexPath:(NSIndexPath *)indexPath;
@end
