//
//  TSWaitForPayTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSWaitForPayTableViewCell.h"
#import "TSWaitOrderModel.h"
#import <BlocksKit+UIKit.h>

@interface TSWaitForPayTableViewCell ()
@property (nonatomic, strong) TSWaitOrderModel *orderModel;
@end
@implementation TSWaitForPayTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.separatorInset = UIEdgeInsetsZero;
    
    [self blindActionHandler];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(TSWaitOrderModel *)orderModel orderDetailButtonHandler:(OrderDetailButtonHandler)orderDetailButtonHandler buyNowButtonHandler:(BuyNowButtonHandler)buyNowButtonHandler{
    
    self.orderCode.text = orderModel.orderCode;
    self.companyName.text = orderModel.companyName;
    self.orderTotalPrice.text = [NSString stringWithFormat:@"￥%d",orderModel.orderTotalPrice];
    self.orderDetailButtonHandler = orderDetailButtonHandler;
    self.buyNowButtonHandler = buyNowButtonHandler;
    self.orderModel = orderModel;
}
- (void)blindActionHandler{
    @weakify(self);
    [self.orderDetialButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.orderDetailButtonHandler(self.orderModel);
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.buyNowButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.buyNowButtonHandler(self.orderModel);
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
