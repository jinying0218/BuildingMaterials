//
//  TSInviteCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSInviteModel;

@interface TSInviteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *inviteName;
@property (weak, nonatomic) IBOutlet UILabel *inviteDes;
@property (weak, nonatomic) IBOutlet UILabel *invitePrice;
@property (weak, nonatomic) IBOutlet UILabel *inviteNumber;

- (void)configureCellWithModel:(TSInviteModel *)model;

@end
