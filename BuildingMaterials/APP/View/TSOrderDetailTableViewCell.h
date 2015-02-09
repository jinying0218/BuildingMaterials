//
//  TSOrderDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

typedef void(^CommentButtonHandler)(NSIndexPath *indexPath);

#import <UIKit/UIKit.h>
@class TSOrderDetailGoodsModel;

@interface TSOrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commentGoodsButton;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)configureCell:(TSOrderDetailGoodsModel *)orderGoodsModel commentButtonHandler:(CommentButtonHandler)commentButtonHandler;
@end
