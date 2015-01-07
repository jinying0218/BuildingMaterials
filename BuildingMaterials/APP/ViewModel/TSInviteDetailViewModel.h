//
//  TSInviteDetailViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSInviteComanyModel.h"
#import "TSInvitePostModel.h"
@interface TSInviteDetailViewModel : NSObject
@property (nonatomic, assign) int postID;
@property (nonatomic, strong) TSInviteComanyModel *comanyModel;
@property (nonatomic, strong) TSInvitePostModel *postModel;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userTel;
@property (nonatomic, strong) NSString *userDes;

@end
