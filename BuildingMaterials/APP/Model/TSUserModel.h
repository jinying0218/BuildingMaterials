//
//  UserModel.h
//  ProInspection
//
//  Created by Aries on 14-7-8.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSUserModel : NSObject

@property (nonatomic, copy) NSString *classFrom;
@property (nonatomic, assign) int userId;
@property (nonatomic, assign) BOOL isLook;
@property (nonatomic, assign) BOOL isUsed;
@property (nonatomic, copy) NSString *loginTime;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *regFrom;
@property (nonatomic, copy) NSString *regTime;
@property (nonatomic, copy) NSString *telephone;

+ (TSUserModel *)getCurrentLoginUser;

- (void) saveToDisk;
@end
