//
//  TSGoodsExchangeTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSGoodsExchangeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstExchangeGoodsImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondExchangeGoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *firstChangeGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *firstWantGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *secondChangeGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *secondWantGoodsName;


- (void)configureCellWithModelArray:(NSMutableArray *)models;

@end
