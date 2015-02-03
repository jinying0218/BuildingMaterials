//
//  TSOrderConfirmTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/31.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSOrderConfirmTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsParamters;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberPrice;

@end
