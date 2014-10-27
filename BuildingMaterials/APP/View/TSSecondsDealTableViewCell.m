//
//  TSSecondsDealTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//


#import "TSSecondsDealTableViewCell.h"

@implementation TSSecondsDealTableViewCell

- (void)awakeFromNib {

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configureCell{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"cell_goodsExchange_bg"]];
    self.backgroundView.frame = CGRectMake( 0, 0, KscreenW, self.frame.size.height - 50);
    
}

@end
