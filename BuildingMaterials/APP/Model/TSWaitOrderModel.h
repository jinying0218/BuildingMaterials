//
//  TSWaitOrderModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSWaitOrderModel : NSObject
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *orderCode;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *orderSureTime;
@property (nonatomic, assign) int orderTotalPrice;
@property (nonatomic, strong) NSString *transportCode;
@property (nonatomic, strong) NSString *transportName;
@property (nonatomic, assign) int transportPrice;
@property (nonatomic, assign) int orderId;
@property (nonatomic, strong) NSArray *goods;

- (void)modelWithDict:(NSDictionary *)dict;
@end
