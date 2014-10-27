//
//  TSInviteViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSInviteViewController.h"

@interface TSInviteViewController ()

@end

@implementation TSInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"贵州建材网\nwww.xxx.com" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
}
@end
