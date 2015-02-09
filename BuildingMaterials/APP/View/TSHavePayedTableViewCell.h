//
//  TSHavePayedTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

typedef void(^OrderDetailButtonHandler)(NSIndexPath *indexPath);
typedef void(^MoneyBackButtonHandler)(NSIndexPath *indexPath);
typedef void(^CheckTransportButtonHandler)(NSIndexPath *indexPath);
typedef void(^ConfirmReceiveButtonHandler)(NSIndexPath *indexPath);

#import <UIKit/UIKit.h>
@class TSWaitOrderModel;

@interface TSHavePayedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *orderDetailButton;
@property (weak, nonatomic) IBOutlet UIButton *moneyBackButton;
@property (weak, nonatomic) IBOutlet UIButton *checkTransportButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmReceiveButton;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)configureCell:(TSWaitOrderModel *)orderModel orderDetailButtonHandler:(OrderDetailButtonHandler)orderDetailButtonHandler moneyBackButtonHandler:(MoneyBackButtonHandler)moneyBackButtonHandler checkTransportButtonHandler:(CheckTransportButtonHandler)checkTransportButtonHandler confirmReceiveButtonHandler:(ConfirmReceiveButtonHandler)confirmReceiveButtonHandler;

@end
