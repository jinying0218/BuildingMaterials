//
//  TSPublishViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSPublishViewModel : NSObject
@property (nonatomic, assign) int forumClassifyId;
@property (strong, nonatomic) NSString *titleInputString;
@property (strong, nonatomic) NSString *contentInputString;
@property (nonatomic, strong) NSMutableArray *imageURLArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableString *imageContent;
@property (strong, nonatomic) NSString *publishContent;

@end
