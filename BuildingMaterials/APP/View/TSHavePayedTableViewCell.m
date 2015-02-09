//
//  TSHavePayedTableViewCell.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSHavePayedTableViewCell.h"
#import "TSWaitOrderModel.h"
#import <BlocksKit+UIKit.h>

typedef void(^OrderDetailButtonHandler)(NSIndexPath *indexPath);
typedef void(^MoneyBackButtonHandler)(NSIndexPath *indexPath);
typedef void(^CheckTransportButtonHandler)(NSIndexPath *indexPath);
typedef void(^ConfirmReceiveButtonHandler)(NSIndexPath *indexPath);
@interface TSHavePayedTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalPrice;
@property (nonatomic, strong) OrderDetailButtonHandler orderDetailButtonHandler;
@property (nonatomic, strong) MoneyBackButtonHandler oneyBackButtonHandler;
@property (nonatomic, strong) CheckTransportButtonHandler checkTransportButtonHandler;
@property (nonatomic, strong) ConfirmReceiveButtonHandler confirmReceiveButtonHandler;

@end
@implementation TSHavePayedTableViewCell

- (void)awakeFromNib {
    [self blindActionHandler];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(TSWaitOrderModel *)orderModel orderDetailButtonHandler:(OrderDetailButtonHandler)orderDetailButtonHandler moneyBackButtonHandler:(MoneyBackButtonHandler)moneyBackButtonHandler checkTransportButtonHandler:(CheckTransportButtonHandler)checkTransportButtonHandler confirmReceiveButtonHandler:(ConfirmReceiveButtonHandler)confirmReceiveButtonHandler{
    
    self.orderCode.text = orderModel.orderCode;
    self.shopName.text = orderModel.companyName;
    if ([orderModel.orderStatus isEqualToString:@"HAVE_PAY"]) {
        self.orderStatus.text = @"等待卖家发货";
        self.checkTransportButton.enabled = NO;
        self.confirmReceiveButton.enabled = NO;
    }else if ([orderModel.orderStatus isEqualToString:@"HAVE_SEND"]){
        self.orderStatus.text = @"卖家已发货";
//        self.checkTransportButton.enabled = NO;
//        self.confirmReceiveButton.enabled = NO;
    }else if ([orderModel.orderStatus isEqualToString:@"HAVE_BACK_ASK"]){
        self.orderStatus.text = @"买家已申请退款";
        self.moneyBackButton.enabled = NO;
        self.confirmReceiveButton.enabled = NO;
    }else if ([orderModel.orderStatus isEqualToString:@"HAVE_BACK"]){
        self.orderStatus.text = @"退款完成";
        self.moneyBackButton.enabled = NO;
        self.confirmReceiveButton.enabled = NO;
    }else if ([orderModel.orderStatus isEqualToString:@"HAVE_GET"]){
        self.orderStatus.text = @"订单完成";
        self.moneyBackButton.enabled = NO;
        self.confirmReceiveButton.enabled = NO;
    }
    self.orderTotalPrice.text = [NSString stringWithFormat:@"￥%d",orderModel.orderTotalPrice];
    self.orderDetailButtonHandler = orderDetailButtonHandler;
    self.oneyBackButtonHandler = moneyBackButtonHandler;
    self.checkTransportButtonHandler = checkTransportButtonHandler;
    self.confirmReceiveButtonHandler = confirmReceiveButtonHandler;
}
- (void)blindActionHandler{
    @weakify(self);
    [self.orderDetailButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.orderDetailButtonHandler(self.indexPath);
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.moneyBackButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.oneyBackButtonHandler(self.indexPath);
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.checkTransportButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.checkTransportButtonHandler(self.indexPath);
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirmReceiveButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.confirmReceiveButtonHandler(self.indexPath);
    } forControlEvents:UIControlEventTouchUpInside];
}

@end
