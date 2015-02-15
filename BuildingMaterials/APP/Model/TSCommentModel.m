//
//  TSCommentModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/18.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCommentModel.h"

@implementation TSCommentModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.app_userId = [[self objectOrNilForKey:@"APP_USERID" fromDictionary:dict] intValue];
    self.comment_content = [self objectOrNilForKey:@"COMMENT_CONTENT" fromDictionary:dict];
    self.comment_time = [self objectOrNilForKey:@"COMMENT_TIME" fromDictionary:dict];
    self.goods_id = [[self objectOrNilForKey:@"GOODS_ID" fromDictionary:dict] intValue];
    self.comment_id = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.N_O = [[self objectOrNilForKey:@"NO" fromDictionary:dict] intValue];
    self.userName = [self objectOrNilForKey:@"USER_NAME" fromDictionary:dict];
    NSMutableString *contactString = [self.userName mutableCopy];
    [contactString replaceCharactersInRange:NSMakeRange( 3, 4) withString:@"****"];
    self.userName = contactString;

}


#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
