//
//  TSInviteComanyModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSInviteComanyModel : NSObject
@property (nonatomic, strong) NSString *companyAddress;
@property (nonatomic, strong) NSString *companyContact;
@property (nonatomic, strong) NSString *companyDes;
@property (nonatomic, strong) NSString *companyImageUrl;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyTelPhone;
@property (nonatomic, assign) int company_Id;
@property (nonatomic, assign) int isRecommend;
@property (nonatomic, strong) NSString *recommendTime;
- (void)setValueForDictionary:(NSDictionary *)dict;

@end
