//
//  TSCategoryCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSCategoryModel;

@interface TSCategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UILabel *categoryDetail;

- (void)configureCellWithModel:(TSCategoryModel *)model;
@end
