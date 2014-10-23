//
//  TSRegisterViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/23.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSRegisterViewController.h"
#import "TSRegisterTwoViewController.h"

@interface TSRegisterViewController ()

@end

@implementation TSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)leftNaviButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getTestButtonClick:(UIButton *)sender {
}
- (IBAction)nextButtonClick:(UIButton *)sender {
    TSRegisterTwoViewController *registerTwoVC = [[TSRegisterTwoViewController alloc] init];
    [self.navigationController pushViewController:registerTwoVC animated:YES];
}

@end
