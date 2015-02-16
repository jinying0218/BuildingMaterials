//
//  TSInvitePostModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/6.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSInvitePostModel : NSObject
@property (nonatomic, assign) int companyId;
@property (nonatomic, assign) int post_id;
@property (nonatomic, assign) int isUsed;
@property (nonatomic, assign) int postAskNumber;    //申请人数
@property (nonatomic, assign) int postClassifyId;
@property (nonatomic, assign) int postCompanyId;

@property (nonatomic, strong) NSString *postDes;
@property (nonatomic, strong) NSString *postName;
@property (nonatomic, assign) int postPrice;
@property (nonatomic, assign) int postNumber;
@property (nonatomic, strong) NSString *postTime;

- (void)setValueForDictionary:(NSDictionary *)dict;

@end
