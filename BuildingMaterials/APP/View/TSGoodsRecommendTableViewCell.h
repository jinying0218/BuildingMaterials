//
//  TSGoodsRecommendTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSGoodsRecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstGoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *firstGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *firstGoodsPrice;
@property (weak, nonatomic) IBOutlet UIImageView *secondGoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *secondGoddsName;
@property (weak, nonatomic) IBOutlet UILabel *secondGoodsPrice;

- (void)configureCellWithModelArray:(NSMutableArray *)models;

@end
