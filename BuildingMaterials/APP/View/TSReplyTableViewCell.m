//
//  TSForumDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSReplyTableViewCell.h"
#import "TSReplyModel.h"
@implementation TSReplyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(TSReplyModel *)model indexPath:(NSIndexPath *)indexPath{
    self.floorNumber.text = [NSString stringWithFormat:@"%d楼",indexPath.row + 1];
    self.replyName.text = model.commentName;
    self.replyContent.text = model.commentContent;
    self.replyTime.text = model.commentTime;
}
@end
