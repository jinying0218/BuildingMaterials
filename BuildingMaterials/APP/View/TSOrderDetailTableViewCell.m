//
//  TSOrderDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderDetailTableViewCell.h"


@interface TSOrderDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *orderHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIButton *commentGoodsButton;

@end
@implementation TSOrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
