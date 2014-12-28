//
//  TSRegisterViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/23.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSRegisterViewController.h"
#import "TSRegisterTwoViewController.h"
#import "TSHttpTool.h"

@interface TSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *checkNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *secureTextfield;

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
    NSString *uuid = [NSString UUIDCode];
    NSDictionary *params = @{ @"telPhone" : telPhone, @"uuid" : uuid};
    [TSHttpTool postWithUrl:codePost_url params:params success:^(id result) {
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
}
- (IBAction)registerButtonClick:(UIButton *)sender {
//    TSRegisterTwoViewController *registerTwoVC = [[TSRegisterTwoViewController alloc] init];
//    [self.navigationController pushViewController:registerTwoVC animated:YES];
}

@end
