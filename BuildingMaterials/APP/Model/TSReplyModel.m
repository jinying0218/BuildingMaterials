//
//  TSReplyModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/24.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSReplyModel.h"

@implementation TSReplyModel

- (void)setValueWithDict:(NSDictionary *)dict{
    self.commentName = [[self objectOrNilForKey:@"COMMENT_NAME" fromDictionary:dict] mutableCopy];
    self.commentTime = [self objectOrNilForKey:@"COMMENT_TIME" fromDictionary:dict];
    self.commentContent = [self objectOrNilForKey:@"FORUM_COMMENT_CONTENT" fromDictionary:dict];
    self.contentId = [[self objectOrNilForKey:@"FORUM_CONTENT_ID" fromDictionary:dict] intValue];
    self.commentId = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.N_O = [[self objectOrNilForKey:@"NO" fromDictionary:dict] intValue];

}


#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
