//
//  TSCommentModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/18.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCommentModel : NSObject
@property (nonatomic, assign) int app_userId;
@property (nonatomic, strong) NSString *comment_content;
@property (nonatomic, strong) NSString *comment_time;
@property (nonatomic, assign) int goods_id;
@property (nonatomic, assign) int comment_id;
@property (nonatomic, assign) int N_O;
@property (nonatomic, strong) NSString *userName;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
