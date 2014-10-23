//
//  TSLoginViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/23.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSLoginViewController.h"
#import "TSRegisterViewController.h"

@interface TSLoginViewController ()

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)registerButtonClick:(UIButton *)sender {
    
    TSRegisterViewController *registerVC = [[TSRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
