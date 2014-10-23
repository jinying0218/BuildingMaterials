//
//  UILabel+TSLabelEX.h
//  ProInspection
//
//  Created by Aries on 14-7-10.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TSLabelEX)

+ (UILabel *)lableWithText:(NSString *)text fontname:(NSString *)fontname fontSize:(CGFloat)font color:(NSString *)color;
/**
 *  返回一个UILabel的size
 *
 *  @return
 */
+ (CGSize)sizeWithLabel:(UILabel *)label;

@end
