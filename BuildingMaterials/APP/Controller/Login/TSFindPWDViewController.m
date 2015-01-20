//
//  TSFindPWDViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/20.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSFindPWDViewController.h"
#import "TSFindPWDViewModel.h"

@interface TSFindPWDViewController ()
@property (nonatomic, strong) TSFindPWDViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *telInput;
@property (weak, nonatomic) IBOutlet UITextField *codeInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) NSString *uuid;

@end

@implementation TSFindPWDViewController
- (instancetype)initWithViewModel:(TSFindPWDViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - set up UI
- (void)setupUI{
    if (self.viewModel.isFindPassword) {
        [self createNavigationBarTitle:@"找回密码" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    }else {
        [self createNavigationBarTitle:@"修改密码" leftButtonImageName:@"Previous" rightButtonImageName:nil];
        self.tabBarController.tabBar.hidden =  YES;

    }
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
}


- (void)blindActionHandler{
    @weakify(self);
    [self.getCodeButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.getCodeButton.enabled = NO;
        
        NSString *telPhone = self.telInput.text;
        self.uuid = [[TSDateFormatterTool shareInstance] dateIntervalString];
        NSDictionary *params = @{ @"telPhone" : telPhone,
                                  @"uuid" : self.uuid};
        [TSHttpTool postWithUrl:codePost_url params:params success:^(id result) {
            NSLog(@"获取验证码:%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"验证码已发送，请注意查收" delay:1];
            }
        } failure:^(NSError *error) {
            NSLog(@"获取验证码:%@",error);
        }];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirmButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSString *telPhone = self.telInput.text;
        NSString *uuid = self.uuid;
        NSString *messageCode = self.codeInput.text;
        NSString *password = self.passwordInput.text;
        NSString *regFrom = @"ios";
        NSDictionary *params = @{@"telPhone":telPhone,
                                 @"uuid":uuid,
                                 @"messageCode":messageCode,
                                 @"password":password,
                                 @"regFrom":regFrom};
        [TSHttpTool postWithUrl:FindPassword_URL params:params success:^(id result) {
            NSLog(@"找回密码:%@",result);
            if ([result[@"success"] intValue] == 1) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"新密码修改成功";
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

    } forControlEvents:UIControlEventTouchUpInside];
}

@end
