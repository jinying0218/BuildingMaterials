//
//  TSCommentTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/16.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCommentTableViewCell.h"

@implementation TSCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSCommentModel *)model indexPath:(NSIndexPath *)indexPath{
    self.contactName.text = @"234";
}
@end
