//
//  TSForumClassifyModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSForumClassifyModel.h"

@implementation TSForumClassifyModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.app_user_id = [[self objectOrNilForKey:@"APP_USER_ID" fromDictionary:dict] intValue];
    self.forum_classify_id = [[self objectOrNilForKey:@"FORUM_CLASSIFY_ID" fromDictionary:dict] intValue];
    self.forum_content = [self objectOrNilForKey:@"FORUM_CONTENT" fromDictionary:dict];
    self.forum_content_comment_number = [[self objectOrNilForKey:@"FORUM_CONTENT_COMMENT_NUMBER" fromDictionary:dict] intValue];
    self.forum_content_time = [self objectOrNilForKey:@"FORUM_CONTENT_TIME" fromDictionary:dict];
    self.forum_content_title = [self objectOrNilForKey:@"FORUM_CONTENT_TITLE" fromDictionary:dict];
    self.forum_user = [self objectOrNilForKey:@"FORUM_USER" fromDictionary:dict];
    self.forum_Id = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.is_recommend = [[self objectOrNilForKey:@"IS_RECOMMEND" fromDictionary:dict] intValue];
    self.N_O = [[self objectOrNilForKey:@"NO" fromDictionary:dict] intValue];
    self.recomment_time = [self objectOrNilForKey:@"RECOMMEND_TIME" fromDictionary:dict];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
