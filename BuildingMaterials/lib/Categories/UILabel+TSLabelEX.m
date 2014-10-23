//
//  UILabel+TSLabelEX.m
//  ProInspection
//
//  Created by Aries on 14-7-10.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "UILabel+TSLabelEX.h"

@implementation UILabel (TSLabelEX)

+ (UILabel *)lableWithText:(NSString *)text fontname:(NSString *)fontName fontSize:(CGFloat)fontSize color:(NSString *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    [label setTextColor:[UIColor colorWithHexString:color]];
    [label setFont:[UIFont fontWithName:fontName size:fontSize]];
    label.adjustsFontSizeToFitWidth = YES;
    return label;

}

+ (CGSize)sizeWithLabel:(UILabel *)label
{
    CGFloat labelW = [label.text sizeWithFont:label.font].width;
    CGFloat labelH = [label.text sizeWithFont:label.font].height;
    
    return CGSizeMake(labelW, labelH);
}
@end
