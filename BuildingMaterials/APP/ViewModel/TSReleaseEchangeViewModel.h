//
//  TSReleaseEchangeViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSReleaseEchangeViewModel : NSObject
@property (nonatomic, strong) NSString *thingName;
@property (nonatomic, strong) NSString *thingWant;
@property (nonatomic, strong) NSString *thingNew;
@property (nonatomic, strong) NSString *contactAddress;
@property (nonatomic, strong) NSString *contactUserName;
@property (nonatomic, strong) NSString *contactTel;
@property (nonatomic, strong) NSString *thingDes;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *urlArray;

@property (assign, nonatomic) int buttonIndex;



@end
