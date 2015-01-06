//
//  TSInviteDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteDetailViewController.h"


@interface TSInviteDetailViewController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *postInfoButton;
@property (weak, nonatomic) IBOutlet UIButton *companyInfoButton;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (strong, nonatomic) IBOutlet UIView *postView;

@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UILabel *postTime;
@property (weak, nonatomic) IBOutlet UILabel *postAskNumber;
@property (weak, nonatomic) IBOutlet UILabel *postPrice;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *postNumber;
@property (weak, nonatomic) IBOutlet UILabel *companyAddress;
@property (weak, nonatomic) IBOutlet UILabel *postDes;
@property (weak, nonatomic) IBOutlet UILabel *postHeart;

@property (strong, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UILabel *companyViewName;
@property (weak, nonatomic) IBOutlet UILabel *companyViewAddress;
@property (weak, nonatomic) IBOutlet UILabel *companyDes;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *contactPerson;

@property (weak, nonatomic) IBOutlet UILabel *telNumber;
@property (weak, nonatomic) IBOutlet UIButton *telButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

@end

@implementation TSInviteDetailViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];

    self.tabBarController.tabBar.hidden = YES;

    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData{
    NSDictionary *params = @{@"postId":[NSString stringWithFormat:@"%d",self.viewModel.postID]};
    [TSHttpTool getWithUrl:Invite_Detail_URL params:params withCache:NO success:^(id result) {
        NSLog(@"招聘详情：%@",result);
        if (result[@"success"]) {
            [self.viewModel.postModel setValueForDictionary:result[@"post"]];
            [self.viewModel.comanyModel setValueForDictionary:result[@"company"]];
        }
        [self layoutSubViews];
    } failure:^(NSError *error) {
        NSLog(@"招聘详情：%@",error);
    }];
    
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"招聘详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    self.rootView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    
    self.headerView.frame = CGRectMake( 0, 44, KscreenW, 30);
    [self.rootView addSubview:self.headerView];
    
    self.headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headerView.layer.borderWidth = 1;
    
    self.companyView.frame = CGRectMake( 0, CGRectGetMaxY(self.headerView.frame), KscreenW, KscreenH - 64 - 30 - 60);
    [self.rootView addSubview:self.companyView];
    
    self.postView.frame = CGRectMake( 0, CGRectGetMaxY(self.headerView.frame), KscreenW, KscreenH - 64 - 30 - 60);
    [self.rootView addSubview:self.postView];
    
    self.postHeart.text = @"凡是扣押证件原件，未标明收费却收取各种费用，要求购买购物卡或者各种商品的，都有诈骗嫌疑";
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.postView.frame), KscreenW, 60);
    [self.rootView addSubview:self.bottomView];
    
}

- (void)layoutSubViews{
    self.postName.text = self.viewModel.postModel.postName;
    self.postTime.text = self.viewModel.postModel.postTime;
    self.postAskNumber.text = [NSString stringWithFormat:@"%d",self.viewModel.postModel.postAskNumber];
    self.postDes.text = self.viewModel.postModel.postDes;
    self.postPrice.text = [NSString stringWithFormat:@"%d",self.viewModel.postModel.postPrice];
    self.postNumber.text = [NSString stringWithFormat:@"%d",self.viewModel.postModel.postNumber];
    self.companyAddress.text = self.viewModel.comanyModel.companyAddress;

    self.companyViewName.text = self.viewModel.comanyModel.companyName;
    self.companyViewAddress.text = self.viewModel.comanyModel.companyAddress;
    self.companyDes.text = self.viewModel.comanyModel.companyDes;
    
    self.contactPerson.text = self.viewModel.comanyModel.companyContact;
    self.telNumber.text = self.viewModel.comanyModel.companyTelPhone;
    
}
- (void)blindActionHandler{
    @weakify(self);
    [self.postInfoButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectedLabel.frame = CGRectMake( 0, 27, KscreenW/2, 2);
        self.postInfoButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.companyInfoButton.backgroundColor = [UIColor whiteColor];
        
        [self.rootView bringSubviewToFront:self.postView];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.companyInfoButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectedLabel.frame = CGRectMake( KscreenW/2, 27, KscreenW/2, 2);
        self.companyInfoButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.postInfoButton.backgroundColor = [UIColor whiteColor];
        
        [self.rootView bringSubviewToFront:self.companyView];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.telButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.viewModel.comanyModel.companyTelPhone]]];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.applyButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.reportButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        
    } forControlEvents:UIControlEventTouchUpInside];
}
@end
