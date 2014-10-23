//
//  HttpRequest.h
//  AutoHome
//
//  Created by Aries on 14-2-10.
//  Copyright (c) 2014年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (PathSize)

//计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path;

+(BOOL)isTimeout:(NSString*)path time:(NSTimeInterval)timeout;

@end
