//
//  TSLoginViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/23.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSLoginViewController.h"
#import "TSRegisterViewController.h"
#import "TSMainTabBarViewController.h"

@interface TSLoginViewController ()

@end

@implementation TSLoginViewController

#pragma mark - controllers methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - set UI
- (void)createTabbarController{

}

#pragma mark - button actions
- (IBAction)loginButtonClick:(UIButton *)sender {
    
    TSMainTabBarViewController *tabbarController = [[TSMainTabBarViewController alloc] init];
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarController;
    [self presentViewController:tabbarController animated:YES completion:^{
        
    }];
}

- (IBAction)registerButtonClick:(UIButton *)sender {
    
    TSRegisterViewController *registerVC = [[TSRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
