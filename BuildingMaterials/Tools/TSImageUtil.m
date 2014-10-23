//
//  TSAddQuestionViewController.m
//  ProInspection
//
//  Created by Aries on 14-7-15.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSImageUtil.h"


static NSString *const TSInspectPhotoPath = @"inspectData/photo/";
@implementation TSImageUtil

+(NSString *)getDefectBaicFilePath {
    
    NSString *path = [[NSFileManager defaultManager] pathForPublicFile:[NSString stringWithFormat:@"%@", TSInspectPhotoPath]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];

    if(!(isDirExist && isDir))    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"Create PhotoFile Directory Failed.");
        }
        NSLog(@"%@",path);
    }
    return path;
}

+(NSString *)getDefectFilePathWithFileName:(NSString *)fileName{
    NSString *path = [[NSFileManager defaultManager] pathForPublicFile:[NSString stringWithFormat:@"%@%@.jpg", TSInspectPhotoPath,fileName]];
    return path;
}

+(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size{
    // 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(size);
    
	// 绘制改变大小的图片
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
	// 从当前context中创建一个改变大小后的图片
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
    
	// 返回新的改变大小后的图片
	return scaledImage;
}


+ (NSString *)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension{
    
    NSString *imagePath;
    if ([[extension lowercaseString] isEqualToString:@"png"])
    {
        imagePath = [[self getDefectBaicFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]];
        [UIImagePNGRepresentation(image) writeToFile:imagePath options:NSAtomicWrite error:nil];
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"])
    {
        imagePath = [[self getDefectBaicFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
        NSError *error = nil;
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:imagePath options:NSAtomicWrite error:&error];
        if (error)
        {
            NSLog(@"%@",error);
        }
    }
    else
    {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
    return imagePath;
}

+(UIImage *)getImagewithFileName:(NSString *)imageName ofType:(NSString *)extension{
    UIImage *image;
    NSString *imagePath;
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        imagePath = [[self getDefectBaicFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]];
        image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        imagePath = [[self getDefectBaicFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
        NSData *data=[NSData dataWithContentsOfFile:imagePath];
        //直接把该图片读出来
        image=[UIImage imageWithData:data];
    } else {
        NSLog(@" get Image Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
    
    
    return image;
}

+ (void)deleteImageWithFileName:(NSString *)imageName ofType:(NSString *)extension{
    
    NSString *imagePath;
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        imagePath = [[self getDefectBaicFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]];
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        imagePath = [[self getDefectBaicFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    } else {
        NSLog(@" get Image Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
    
}


@end
