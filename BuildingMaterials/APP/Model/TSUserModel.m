//
//  UserModel.m
//  ProInspection
//
//  Created by Aries on 14-7-8.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSUserModel.h"

@implementation TSUserModel

static TSUserModel *_currUser;
+ (TSUserModel *) getCurrentLoginUser
{
    
    if (_currUser == nil){
        _currUser = [self readFromDisk];
        if (_currUser == nil){
            // 第一次登陆
            _currUser = [[self alloc] init];
        }
    }
    return _currUser;
}

- (void)saveToDisk
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/CurrUser"];
    
    NSLog(@"filename:%@",filename);
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:filename];
    if (!success) {
        NSLog(@"归档失败");
    }
}

+ (TSUserModel *)readFromDisk
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/CurrUser"];
    
    TSUserModel *currUser = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    
    NSLog(@"user is %@", currUser.userName);
    return currUser;
}


- (void)cleanDiskData
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/CurrUser"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filename]){
        [fm removeItemAtPath:filename error:nil];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"TSUserModelUndefinedKey:%@",key);
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accessSecret forKey:@"accessSecret"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.cellphone forKey:@"cellphone"];
    [aCoder encodeInt:self.companyId forKey:@"companyId"];
    [aCoder encodeObject:self.companyName forKey:@"companyName"];
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeInt:self.isValid forKey:@"isValid"];
    [aCoder encodeInt:self.projectId forKey:@"projectId"];
    [aCoder encodeInt:self.sex forKey:@"sex"];
    [aCoder encodeInt:self.departmentId forKey:@"departmentId"];
    [aCoder encodeInt:self.departmentTypeId forKey:@"departmentTypeId"];
    [aCoder encodeInt:self.subCompanyId forKey:@"subCompanyId"];
    [aCoder encodeObject:self.subCompanyName forKey:@"subCompanyName"];
    [aCoder encodeInt:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.accessSecret = [aDecoder decodeObjectForKey:@"accessSecret"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.cellphone = [aDecoder decodeObjectForKey:@"cellphone"];
        self.companyId = [aDecoder decodeIntForKey:@"companyId"];
        self.companyName = [aDecoder decodeObjectForKey:@"companyName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.isValid = [aDecoder decodeIntForKey:@"isValid"];
        self.projectId = [aDecoder decodeIntForKey:@"projectId"];
        self.sex = [aDecoder decodeIntForKey:@"sex"];
        self.departmentId = [aDecoder decodeIntForKey:@"departmentId"];
        self.departmentTypeId = [aDecoder decodeIntForKey:@"departmentTypeId"];
        self.subCompanyId = [aDecoder decodeIntForKey:@"subCompanyId"];
        self.subCompanyName = [aDecoder decodeObjectForKey:@"subCompanyName"];
        self.userId = [aDecoder decodeIntForKey:@"userId"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];

    }
    return self;
}

@end
