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
    NSLog(@"filename:%@",KaccountDataPath);
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:KaccountDataPath];
    if (!success) {
        NSLog(@"归档失败");
    }
}

+ (TSUserModel *)readFromDisk
{
    TSUserModel *currUser = [NSKeyedUnarchiver unarchiveObjectWithFile:KaccountDataPath];
    
    NSLog(@"user is %@", currUser.telephone);
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
    [aCoder encodeObject:self.classFrom forKey:@"classFrom"];
    [aCoder encodeInt:self.userId forKey:@"userId"];
    [aCoder encodeBool:self.isLook forKey:@"isLook"];
    [aCoder encodeBool:self.isUsed forKey:@"isUsed"];
    [aCoder encodeObject:self.loginTime forKey:@"loginTime"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.regFrom forKey:@"regFrom"];
    [aCoder encodeObject:self.regTime forKey:@"regTime"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.classFrom = [aDecoder decodeObjectForKey:@"classFrom"];
        self.userId = [aDecoder decodeIntForKey:@"userId"];
        self.isLook = [aDecoder decodeBoolForKey:@"isLook"];
        self.isUsed = [aDecoder decodeBoolForKey:@"isUsed"];
        self.loginTime = [aDecoder decodeObjectForKey:@"loginTime"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.regFrom = [aDecoder decodeObjectForKey:@"regFrom"];
        self.regTime = [aDecoder decodeObjectForKey:@"regTime"];
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];

    }
    return self;
}

@end
