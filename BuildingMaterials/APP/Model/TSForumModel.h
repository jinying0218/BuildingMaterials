//
//  TSForumModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/22.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSForumModel : NSObject
@property (nonatomic, strong) NSString *forumClassifyImage;
@property (nonatomic, strong) NSString *forumClassifyImage2;
@property (nonatomic, strong) NSString *forumClassifyName;
@property (nonatomic, assign) int forumClassifyID;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
