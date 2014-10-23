//
//  TSRegisterTwoViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/23.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSRegisterTwoViewController.h"

@interface TSRegisterTwoViewController ()

@end

@implementation TSRegisterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)leftNaviButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)finishButtonClick:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
