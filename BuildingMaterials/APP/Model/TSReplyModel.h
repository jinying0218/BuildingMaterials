//
//  TSReplyModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/24.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSReplyModel : NSObject
@property (nonatomic, strong) NSMutableString *commentName;
@property (nonatomic, strong) NSString *commentTime;
@property (nonatomic, strong) NSString *commentContent;
@property (nonatomic, assign) int contentId;
@property (nonatomic, assign) int commentId;
@property (nonatomic, assign) int N_O;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
