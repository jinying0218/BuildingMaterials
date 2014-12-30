//
//  TSSecondsDealTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSSecondsDealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fristGoodsImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondGoodsImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdGoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *fristGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *secondGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *thirdGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *fristGoodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *secondGoodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *thirdGoodsPrice;

- (void)configureCellWithModelArray:(NSMutableArray *)models;
@end
