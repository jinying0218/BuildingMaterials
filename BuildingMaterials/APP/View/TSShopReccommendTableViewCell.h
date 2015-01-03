//
//  TSShopReccommendTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSShopReccommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fristShopImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondShopImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdShopImage;
@property (weak, nonatomic) IBOutlet UILabel *firstShopName;
@property (weak, nonatomic) IBOutlet UILabel *secondShopName;
@property (weak, nonatomic) IBOutlet UILabel *thirdShopName;

- (void)configureCellWithModelArray:(NSMutableArray *)models;

@end
