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
#import "TSUserModel.h"

#import "TSFindPWDViewController.h"
#import "TSFindPWDViewModel.h"

@interface TSLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;


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
        [self showProgressHUD];
        NSString *telPhone = self.userNameTextfield.text;
        NSString *password = self.pwdTextField.text;
        NSDictionary *params = @{@"telPhone":telPhone,@"password":password};
        [TSHttpTool postWithUrl:Login_URL params:params success:^(id result) {
            NSLog(@"登陆:%@",result);
            [self hideProgressHUD];
            if ([result[@"success"] intValue] == 1) {
                NSDictionary *appUser = [result objectForKey:@"appUser"];
                TSUserModel *userModel = [[TSUserModel alloc] init];
                userModel.classFrom = appUser[@"class"];
                userModel.userId = [appUser[@"id"] intValue];
                userModel.isLook = [appUser[@"isLook"] boolValue];
                userModel.isUsed = [appUser[@"isUsed"] boolValue];
                userModel.loginTime = appUser[@"loginTime"];
                userModel.password = appUser[@"password"];
                userModel.regFrom = appUser[@"regFrom"];
                userModel.regTime = appUser[@"regTime"];
                userModel.telephone = appUser[@"telephone"];
                
                [userModel saveToDisk];
//                NSLog(@"%d---%d",userModel.userId,userModel.isLook);
                TSMainTabBarViewController *tabbarController = [[TSMainTabBarViewController alloc] init];
                [self presentViewController:tabbarController animated:YES completion:nil];
            }else if ([result[@"success"] intValue] == 0){
                [self showProgressHUD:@"登陆失败" delay:1];
            }

        } failure:^(NSError *error) {
            NSLog(@"login:%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.forgetPasswordButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSFindPWDViewModel *viewModel = [[TSFindPWDViewModel alloc] init];
        viewModel.isFindPassword = YES;
        TSFindPWDViewController *findPWDVC = [[TSFindPWDViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:findPWDVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - button actions
- (IBAction)registerButtonClick:(UIButton *)sender {
    TSRegisterViewController *registerVC = [[TSRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
