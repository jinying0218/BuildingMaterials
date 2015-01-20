//
//  TSAddressViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSAddressViewController.h"
#import "TSAddressViewModel.h"
#import "TSUserModel.h"

@interface TSAddressViewController ()
@property (nonatomic, strong) TSAddressViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *cover;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameInput;
@property (weak, nonatomic) IBOutlet UITextField *contactTelNumberInput;
@property (weak, nonatomic) IBOutlet UITextField *addressInput;

@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@end

@implementation TSAddressViewController
- (instancetype)initWithViewModel:(TSAddressViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden =  YES;
    [self initializeData];
    [self setupUI];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initializeData{
    TSUserModel *userModel = [TSUserModel getCurrentLoginUser];
    NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",userModel.userId]};
    [TSHttpTool getWithUrl:Address_URL params:params withCache:NO success:^(id result) {
        NSLog(@"获取地址:%@",result);
        if ([result[@"success"] intValue] == 1) {
            
        }
    } failure:^(NSError *error) {
        NSLog(@"获取地址:%@",error);
    }];
}

#pragma mark - set up UI
- (void)setupUI{
    [self createNavigationBarTitle:@"地址管理" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.addressView.frame = CGRectMake( 0, KscreenH, KscreenW, 207);
}


- (void)blindActionHandler{
    @weakify(self);
    [self.bottomButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.cover.hidden = !self.cover.hidden;
        self.addressView.hidden = !self.addressView.hidden;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.addressView.frame;
            frame.origin.y = KscreenH - 207;
            self.addressView.frame = frame;
        } completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.saveButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [UIView animateWithDuration:0.25 animations:^{
            self.cover.hidden = !self.cover.hidden;
            CGRect frame = self.addressView.frame;
            frame.origin.y = KscreenH;
            self.addressView.frame = frame;
        } completion:^(BOOL finished) {
            if (finished) {
                self.addressView.hidden = !self.addressView.hidden;
            }
        }];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [UIView animateWithDuration:0.25 animations:^{
            self.cover.hidden = !self.cover.hidden;
            CGRect frame = self.addressView.frame;
            frame.origin.y = KscreenH;
            self.addressView.frame = frame;
        } completion:^(BOOL finished) {
            if (finished) {
                self.addressView.hidden = !self.addressView.hidden;
            }
        }];

    } forControlEvents:UIControlEventTouchUpInside];
}
@end
