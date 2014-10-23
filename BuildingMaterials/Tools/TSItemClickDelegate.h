//
//  TSItemClickDelegate.h
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSItemClickDelegate <NSObject>

@optional
- (void)rootViewItemClick:(NSIndexPath *)indexPath;
//管理人员
- (void)administratorViewItemClick:(NSIndexPath *)indexPath;
//工程人员
- (void)projectViewItemClick:(NSIndexPath *)indexPath;
//安保人员
- (void)securityViewItemClick:(NSIndexPath *)indexPath;
- (void)onGuardViewItemClick:(NSIndexPath *)indexPath;
- (void)bottomLeftButtonClick:(UIButton *)button;
- (void)bottomRightButtonClick:(UIButton *)button;

- (void)tableViewHeaderViewButtonClick:(UIButton *)button;
@end
