//
//  TSForumDetailViewController.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSBaseViewController.h"

@interface TSForumClassifyDetailViewController : TSBaseViewController
@property (nonatomic, assign) int forumClassifyId;
@property (nonatomic, strong) NSString *forumClassifyName;
@property (nonatomic, strong) NSString *forumClassifyImageURL;

@end