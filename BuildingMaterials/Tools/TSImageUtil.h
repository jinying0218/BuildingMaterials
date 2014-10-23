//
//  TSAddQuestionViewController.m
//  ProInspection
//
//  Created by Aries on 14-7-15.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardPaths.h"

@interface TSImageUtil : NSObject

+(NSString *)getDefectFilePathWithFileName:(NSString *)fileName;
+(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;
+(NSString *)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension;
+(UIImage *)getImagewithFileName:(NSString *)imageName ofType:(NSString *)extension;
+(void)deleteImageWithFileName:(NSString *)imageName ofType:(NSString *)extension;
@end
