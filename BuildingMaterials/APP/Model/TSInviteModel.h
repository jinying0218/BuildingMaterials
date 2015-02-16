//
//  TSInviteModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSInviteModel : NSObject
@property (nonatomic, strong) NSString *COMPANY_ADDRESS;
@property (nonatomic, assign) int COMPANY_ID;
@property (nonatomic, strong) NSString *COMPANY_NAME;
@property (nonatomic, assign) int I_D;
@property (nonatomic, assign) int IS_USED;
@property (nonatomic, assign) int N_O;
@property (nonatomic, assign) int POST_ASK_NUMBER;  //申请人数
@property (nonatomic, assign) int POST_CLASSIFY_ID;
@property (nonatomic, assign) int POST_COMPANY_ID;
@property (nonatomic, strong) NSString *POST_DES;
@property (nonatomic, strong) NSString *POST_NAME;
@property (nonatomic, assign) int POST_NUMBER;
@property (nonatomic, assign) int POST_PRICE;
@property (nonatomic, strong) NSString *POST_TIME;

- (void)setValueForDictionary:(NSDictionary *)dict;
@end
