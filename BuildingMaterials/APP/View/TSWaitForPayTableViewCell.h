//
//  TSWaitForPayTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//
@class TSWaitOrderModel;
//待研究是否需要返回当前的model???
typedef void(^OrderDetailButtonHandler)(TSWaitOrderModel *currentOrderModel);
typedef void(^BuyNowButtonHandler)(TSWaitOrderModel *currentOrderModel);

#import <UIKit/UIKit.h>
@interface TSWaitForPayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalPrice;
@property (weak, nonatomic) IBOutlet UIButton *orderDetialButton;
@property (weak, nonatomic) IBOutlet UIButton *buyNowButton;
@property (nonatomic, strong) OrderDetailButtonHandler orderDetailButtonHandler;
@property (nonatomic, strong) BuyNowButtonHandler buyNowButtonHandler;

- (void)configureCell:(TSWaitOrderModel *)orderModel orderDetailButtonHandler:(OrderDetailButtonHandler)orderDetailButtonHandler buyNowButtonHandler:(BuyNowButtonHandler)buyNowButtonHandler;
@end
