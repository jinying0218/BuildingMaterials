//
//  TSRegisterViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/23.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSRegisterViewController.h"
#import "TSRegisterTwoViewController.h"
#import "TSDateFormatterTool.h"

@interface TSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *checkNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *secureTextfield;
@property (nonatomic, strong) NSString *uuid;
@end

@implementation TSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUIAttributes];
    [self bindActionHandler];
    
}
- (void)configUIAttributes{
    self.phoneNumberTextfield.layer.borderWidth = 1;
    self.checkNumberTextfield.layer.borderWidth = 1;
    self.secureTextfield.layer.borderWidth = 1;

    self.phoneNumberTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.checkNumberTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.secureTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;

}
- (void)bindActionHandler {
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)leftNaviButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getTestButtonClick:(UIButton *)sender {
    
    NSString *telPhone = self.phoneNumberTextfield.text;
//    NSString *uuid = [NSString UUIDCode];
    self.uuid = [[TSDateFormatterTool shareInstance] dateIntervalString];
    NSDictionary *params = @{ @"telPhone" : telPhone,
                              @"uuid" : self.uuid};
    [TSHttpTool postWithUrl:codePost_url params:params success:^(id result) {
        NSLog(@"获取验证码:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self showProgressHUD:@"获取验证码成功" delay:1];
        }
    } failure:^(NSError *error) {
        NSLog(@"获取验证码:%@",error);
    }];

}
- (IBAction)registerButtonClick:(UIButton *)sender {
    NSString *telPhone = self.phoneNumberTextfield.text;
    NSString *uuid = self.uuid;
    NSString *messageCode = self.checkNumberTextfield.text;
    NSString *password = self.secureTextfield.text;
    NSString *regFrom = @"ios";
    NSDictionary *params = @{@"telPhone":telPhone,
                             @"uuid":uuid,
                             @"messageCode":messageCode,
                             @"password":password,
                             @"regFrom":regFrom};
    [TSHttpTool postWithUrl:Regist_URL params:params success:^(id result) {
        NSLog(@"注册:%@",result);
        if ([result[@"success"] intValue] == 1) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"注册成功";
            dispatch_time_t poptime =
            dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
            dispatch_after(poptime, dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }else if ([result[@"success"] intValue] == 0 && [result[@"errorMsg"] isEqualToString:@"have_reg"]){
            [self showProgressHUD:@"该手机号码已注册" delay:1];
        }else if ([result[@"success"] intValue] == 0 && [result[@"errorMsg"] isEqualToString:@"code_error"]){
            [self showProgressHUD:@"验证码错误" delay:1];
        }
        else{
            [self showProgressHUD:@"注册失败" delay:1];

        }
    } failure:^(NSError *error) {
        
    }];
    
    
//    TSRegisterTwoViewController *registerTwoVC = [[TSRegisterTwoViewController alloc] init];
//    [self.navigationController pushViewController:registerTwoVC animated:YES];
}

@end
