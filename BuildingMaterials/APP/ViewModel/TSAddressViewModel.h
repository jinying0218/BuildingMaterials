//
//  TSAddressViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAddressViewModel : NSObject
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSString *telNumber;
@property (nonatomic, strong) NSString *addressString;
@property (nonatomic, strong) NSMutableArray *addressArray;

@end
