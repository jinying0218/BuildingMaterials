//
//  GVHttpTool.h
//
//
//  Created by Aries on 14-5-27.
//  Copyright (c) 2014年 Aries. All rights reserved.


#import <Foundation/Foundation.h>

/**
 * 请求成功之后的回调
 *
 * @prama json 后台返回的数据类型
 */
typedef void(^TSHttpSuccess)(id result);

/**
 * 请求失败之后的回调
 *
 * @prama error 错误信息
 */
typedef void(^TSHttpFailure)(NSError *error);


typedef void(^CurrentStatus)(NSInteger currentStatus);


@interface TSHttpTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(TSHttpSuccess)success failure:(TSHttpFailure)failure;
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params withCache:(BOOL)isCache success:(TSHttpSuccess)success failure:(TSHttpFailure)failure;


+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params pictureName:(NSString *)pictureName mimeType:(NSString *)pictureType success:(TSHttpSuccess)success failure:(TSHttpFailure)failure;

/**
 *  发送队列 GET请求
 *
 *  @param threadCount     队列个数
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 */

+ (void)requestWithUrl:(NSString *)url params:(NSDictionary *)params threadCount:(int)threadCount success:(TSHttpSuccess)success failure:(TSHttpFailure)failure;

+ (void)getCurrentNetworkStatus:(CurrentStatus)currentStatus;

@end
