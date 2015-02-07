//
//  TSOrderTableFooterView.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSOrderTableFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *transportName;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) NSInteger indexSection;
@end
