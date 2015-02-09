//
//  TSOrderDetailTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

typedef void(^CommentButtonHandler)();

#import <UIKit/UIKit.h>
@class TSOrderDetailGoodsModel;

@interface TSOrderDetailTableViewCell : UITableViewCell
- (void)configureCell:(TSOrderDetailGoodsModel *)orderGoodsModel commentButtonHandler:(CommentButtonHandler)commentButtonHandler;
@end
