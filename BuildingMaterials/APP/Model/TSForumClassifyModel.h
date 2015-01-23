//
//  TSForumClassifyModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSForumClassifyModel : NSObject
@property (nonatomic, assign) int app_user_id;
@property (nonatomic, assign) int forum_classify_id;
@property (nonatomic, strong) NSString *forum_content;
@property (nonatomic, assign) int forum_content_comment_number;
@property (nonatomic, strong) NSString *forum_content_time;
@property (nonatomic, strong) NSString *forum_content_title;
@property (nonatomic, strong) NSString *forum_user;
@property (nonatomic, assign) int forum_Id;
@property (nonatomic, assign) int is_recommend;
@property (nonatomic, assign) int N_O;
@property (nonatomic, strong) NSString *recomment_time;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
