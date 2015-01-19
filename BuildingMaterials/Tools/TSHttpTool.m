//
//  GVHttpTool.h
//
//
//  Created by Aries on 14-5-27.
//  Copyright (c) 2014年 Aries. All rights reserved.


#import "TSHttpTool.h"
#import "AFNetworking.h"

@implementation TSHttpTool

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 失球失败回调
 *
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(TSHttpSuccess)success failure:(TSHttpFailure)failure
{
    url = [url URLEncodedString];
    
    [self requestWithMethod:@"POST" url:url params:params withCache:NO success:success failure:failure];
}

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params withCache:(BOOL)isCache success:(TSHttpSuccess)success failure:(TSHttpFailure)failure
{
    //如果url有中文等特殊字符需要编码
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [url URLEncodedString];
    
//    NSLog(@"从网络获取数据GET");
    [self requestWithMethod:@"GET" url:url params:params withCache:isCache success:success failure:failure];

}

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params withCache:(BOOL)isCache success:(TSHttpSuccess)success failure:(TSHttpFailure)failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //一般上传
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json", @"text/json",
      @"text/javascript", @"text/html", nil]];
    manager.requestSerializer.timeoutInterval = 90;
    
    if ([method isEqualToString:@"POST"]){
        
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (success){
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                success(json);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            failure(error);
        }];
        
    }else{
        if (isCache) {
            manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
            NSLog(@"cache");
        }
        [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"GETSuccess: %@", responseObject);
            if (success){
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"GETSuccess: %@", json);
                success(json);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"GETError: %@", error);
            if (failure) {
                failure(error);
            }

        }];
    }
    
    
}


+ (void)requestWithUrl:(NSString *)url params:(NSDictionary *)params threadCount:(int)threadCount success:(TSHttpSuccess)success failure:(TSHttpFailure)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //一般上传
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    for (int i = 0; i < threadCount; i ++){
        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:url] absoluteString] parameters:params error:nil];
        
        AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            if (success){
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                //                NSLog(@"GETSuccess: %@", json);
                success(json);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"GETError: %@", error);
            if (failure) {
                failure(error);
            }

        }];
        [operation start];
        [manager.operationQueue addOperation:operation];
    }
}


#pragma mark 单独上传图片
+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params pictureName:(NSString *)pictureName mimeType:(NSString *)pictureType success:(TSHttpSuccess)success failure:(TSHttpFailure)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //上传图片
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if ([pictureName isEqualToString:@"jpeg"]){
            NSString *fileName = [NSString stringWithFormat:@"%@.%@",pictureName,pictureType];
            NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:fileName], 1.0);
            [formData appendPartWithFileData:imageData name:pictureName fileName:fileName mimeType:pictureType];
        }else{
            NSString *fileName = [NSString stringWithFormat:@"%@.%@",pictureName,pictureType];
            NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:fileName]);
            [formData appendPartWithFileData:imageData name:pictureName fileName:fileName mimeType:pictureType];
        }
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        NSLog(@"responseObject: %@", responseObject);
        
        if (success){
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)getCurrentNetworkStatus:(CurrentStatus)currentStatus
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        currentStatus(status);
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)loadFromBackground:(NSString *)cachesPath success:(TSHttpSuccess)success
{
    if (success) {
        id json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:cachesPath] options:NSJSONReadingMutableLeaves error:nil];
        success(json);
    }else{
        NSLog(@"缓存获取数据失败");
    }
}



//- (void)resumeDownload
//{
//    
//    NSURL *url = [NSURL URLWithString:@"http://static.qiyi.com/ext/common/QIYImedia_Mac_5.dmg"];
//    // 2.   指定文件保存路径
//    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *downloadPath = [documents[0]stringByAppendingPathComponent:@"QIYImedia_Mac_5.dmg"];
//    // 3.   创建NSURLRequest
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    // 4.   创建AFURLConnectionOperation
//    self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    // 5.   设置操作的输出流（在网络中的数据是以流的方式传输的，告诉操作把文件保存在第2步设置的路径中）
//    [self.operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:downloadPath append:NO]];
//    // 6.   设置下载进程处理块代码
//    // 6.1 bytesRead 读取的字节——这一次下载的字节数
//    // 6.2 totalBytesRead 读取的总字节——已经下载完的
//    // 6.3 totalBytesExpectedToRead 希望读取的总字节——就是文件的总大小
//    [self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        // 做下载进度百分比的工作
//        NSLog(@"下载百分比:%f", ((float)totalBytesRead / totalBytesExpectedToRead)*100);
//    }];
//    // 7.   操作完成块代码
//    [self.operation setCompletionBlock:^{
//        
//        // 1. 定义要解压缩的文件 —— downloadPath
//        // 2. 要解压缩的目标目录
//        // 3. 调用类方法解压缩
//        //        [SSZipArchive unzipFileAtPath:downloadPath toDestination:documents[0]];
//        
//        //        [[NSFileManager defaultManager]removeItemAtPath:downloadPath error:nil];
//    }];
//    
//    
//    // 8   启动操作
//    [self.operation start];
//    
//}

@end
