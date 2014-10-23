//
//  UserModel.h
//  ProInspection
//
//  Created by Aries on 14-7-8.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSUserModel : NSObject

@property (nonatomic, copy) NSString *accessSecret;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, assign) int companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSArray *groupList;
@property (nonatomic, assign) int isValid;
@property (nonatomic, assign) int projectId;
@property (nonatomic, assign) int sex;
@property (nonatomic, assign) int subCompanyId;
@property (nonatomic, copy) NSString *subCompanyName;
@property (nonatomic, assign) int userId;
@property (nonatomic, copy) NSString *userName; // 用户的唯一标识
@property (nonatomic, assign) int departmentId; // 用户的唯一标识
@property (nonatomic, assign) int departmentTypeId; // 部门类型ID

+ (TSUserModel *)getCurrentLoginUser;

- (void) saveToDisk;
@end
