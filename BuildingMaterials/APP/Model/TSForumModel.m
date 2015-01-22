//
//  TSForumModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/22.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSForumModel.h"

@implementation TSForumModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.forumClassifyName = [self objectOrNilForKey:@"forumClassifyName" fromDictionary:dict];
    self.forumClassifyImage = [self objectOrNilForKey:@"forumClassifyImage" fromDictionary:dict];
    self.forumClassifyImage2 = [self objectOrNilForKey:@"forumClassifyImage2" fromDictionary:dict];
    self.forumClassifyID = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
