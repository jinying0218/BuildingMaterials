//
//  TSCommentTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/16.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSCommentModel;
@interface TSCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *commentDate;

- (void)configureCellWithModel:(TSCommentModel *)model indexPath:(NSIndexPath *)indexPath;
@end
