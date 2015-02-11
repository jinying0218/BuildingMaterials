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
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, assign) int seconds;    //倒计时
@property (nonatomic, strong) NSString *secondsString;
@end

@implementation TSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUIAttributes];
    [self blindViewModel];
    [self bindActionHandler];
    
}
- (void)configUIAttributes{
    self.phoneNumberTextfield.layer.borderWidth = 1;
    self.checkNumberTextfield.layer.borderWidth = 1;
    self.secureTextfield.layer.borderWidth = 1;

    self.phoneNumberTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.checkNumberTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.secureTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;

    self.secondsLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (void)bindActionHandler {
    
    
}
- (void)blindViewModel{
//    [self.KVOController
//     observe:self
//     keyPath:@keypath(self,seconds)
//     options:NSKeyValueObservingOptionNew
//     block:^(TSRegisterViewController *observer, NSString *secondsString, NSDictionary *change) {
//         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
//             if ([change[NSKeyValueChangeNewKey] isEqualToString:@"0"]) {
//                 observer.getCodeButton.enabled = YES;
//                 [observer.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//             }
//         }
//     }];

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
    @weakify(self);
    [TSHttpTool postWithUrl:codePost_url params:params success:^(id result) {
        NSLog(@"注册获取验证码:%@",result);
        @strongify(self);
        if ([result[@"success"] intValue] == 1) {
            [self showProgressHUD:@"获取验证码成功,请注意查收" delay:1];
            self.seconds = 60;
            [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
                @strongify(self);
                self.seconds -= 1;
                if (self.seconds > 0) {
//                    [self.getCodeButton setTitle:[NSString stringWithFormat:@"倒计时(%ds)",self.seconds] forState:UIControlStateNormal];
                    self.secondsLabel.hidden = NO;
                    self.secondsLabel.text = [NSString stringWithFormat:@"倒计时(%ds)",self.seconds];
                    self.getCodeButton.hidden = YES;
                }else {
                    [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self.getCodeButton.hidden = NO;
                    self.secondsLabel.hidden = YES;
                }
            } repeats:YES];
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
