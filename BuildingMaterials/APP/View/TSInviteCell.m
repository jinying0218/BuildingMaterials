//
//  TSInviteCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteCell.h"
//#import <UIImageView+WebCache.h>
#import "TSInviteModel.h"

@implementation TSInviteCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(TSInviteModel *)model{
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    self.inviteName.text = model.POST_NAME;
    self.inviteDes.text = model.POST_DES;
    self.invitePrice.text = [NSString stringWithFormat:@"%d/月",model.POST_PRICE];
    self.inviteNumber.text = [NSString stringWithFormat:@"已有%d人申请",model.POST_ASK_NUMBER];
}
@end
