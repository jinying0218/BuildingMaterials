//
//  TSTransportModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTransportModel : NSObject
@property (nonatomic, assign) int companyId;
@property (nonatomic, assign) int tans_id;
@property (nonatomic, assign) int status;
@property (nonatomic, assign) int transportFee;     //商品的运费
@property (nonatomic, assign) int transportFirstFee;    //运送方式未超重价格(按重量算价时有)
@property (nonatomic, assign) int transportFirstWeight; //首重(按重量算价时有)
@property (nonatomic, strong) NSString *transportName;  //方案名称
@property (nonatomic, assign) int transportOverFee;     //运送方式超出重量的单价(按重量算价时有)
@property (nonatomic, assign) int transportType;        //运送方式类型(一口价(代码为 3)买 家自取(代码为 4) 免运费(代买为 1) 按重量算价代码 为(2))

- (void)modelWithDict:(NSDictionary *)dict;
@end
