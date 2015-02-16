//
//  TSOrderDetailTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderDetailTableViewCell.h"
#import "TSOrderDetailGoodsModel.h"
#import <UIImageView+WebCache.h>
#import <BlocksKit+UIKit.h>

@interface TSOrderDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *orderHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsParameters;

@property (nonatomic, strong) TSOrderDetailGoodsModel *orderGoodsModel;
@property (nonatomic, strong) CommentButtonHandler commentButtonHandler;

@end
@implementation TSOrderDetailTableViewCell

- (void)awakeFromNib {
    [self blindActionHandler];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCell:(TSOrderDetailGoodsModel *)orderGoodsModel commentButtonHandler:(CommentButtonHandler)commentButtonHandler{
    [self.orderHeaderImage sd_setImageWithURL:[NSURL URLWithString:orderGoodsModel.goodsHeadImage] placeholderImage:[UIImage imageNamed:@"not_load"]];
    self.goodsName.text = orderGoodsModel.goodsName;
    self.goodsPrice.text = [NSString stringWithFormat:@"￥%.2f*%d",orderGoodsModel.orderGoodsPrice,orderGoodsModel.goodsNumber];
    self.goodsParameters.text = orderGoodsModel.goodsParameters;
    self.commentButtonHandler = commentButtonHandler;
}

- (void)blindActionHandler{
    @weakify(self);
    [self.commentGoodsButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.commentButtonHandler(self.indexPath);
    } forControlEvents:UIControlEventTouchUpInside];
    
}

@end
