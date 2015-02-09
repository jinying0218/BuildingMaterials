//
//  TSAddressViewController.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//
typedef void(^SelectedAddress)(NSString *address);

#import "TSBaseViewController.h"
@class TSAddressViewModel;
@interface TSAddressViewController : TSBaseViewController

- (instancetype)initWithViewModel:(TSAddressViewModel *)viewModel address:(SelectedAddress)selecedAddress;
@end
