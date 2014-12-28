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
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation TSLoginViewController

#pragma mark - controllers methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUIAttributes];
    [self bindActionHandler];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - set UI
- (void)configUIAttributes{

}
- (void)bindActionHandler{
    @weakify(self);
    [self.loginButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSString *telPhone = self.userNameTextfield.text;
        NSString *password = self.pwdTextField.text;
        NSDictionary *params = @{@"telPhone":telPhone,@"password":password};
        [TSHttpTool postWithUrl:Login_URL params:params success:^(id result) {
            TSMainTabBarViewController *tabbarController = [[TSMainTabBarViewController alloc] init];
            [self presentViewController:tabbarController animated:YES completion:^{
                
            }];

        } failure:^(NSError *error) {
            
        }];

    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - button actions
- (IBAction)registerButtonClick:(UIButton *)sender {
    
    TSRegisterViewController *registerVC = [[TSRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
