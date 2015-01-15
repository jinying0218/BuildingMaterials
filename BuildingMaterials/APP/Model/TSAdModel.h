//
//  TSAdModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/13.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAdModel : NSObject
@property (nonatomic, assign) int ad_go_ID;
@property (nonatomic, strong) NSString *ad_showType;
@property (nonatomic, strong) NSString *ad_title;
@property (nonatomic, strong) NSString *ad_type;
@property (nonatomic, strong) NSString *ad_url;
@property (nonatomic, assign) int company_ID;
@property (nonatomic, assign) int ad_ID;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
