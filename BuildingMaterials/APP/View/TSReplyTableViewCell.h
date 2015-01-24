//
//  TSForumDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSReplyModel;
@interface TSReplyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *floorNumber;
@property (weak, nonatomic) IBOutlet UILabel *replyName;
@property (weak, nonatomic) IBOutlet UILabel *replyContent;
@property (weak, nonatomic) IBOutlet UILabel *replyTime;

- (void)configureCell:(TSReplyModel *)model indexPath:(NSIndexPath *)indexPath;
@end
