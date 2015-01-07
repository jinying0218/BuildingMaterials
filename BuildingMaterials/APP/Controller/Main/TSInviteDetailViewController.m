//
//  TSInviteDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteDetailViewController.h"
#import "TSUserModel.h"

@interface TSInviteDetailViewController ()<UITextViewDelegate>

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
@property (strong, nonatomic) IBOutlet UIView *applyView;
@property (weak, nonatomic) IBOutlet UITextField *userNameInput;
@property (weak, nonatomic) IBOutlet UITextField *telInput;
@property (weak, nonatomic) IBOutlet UITextView *resumeInput;
@property (weak, nonatomic) IBOutlet UIButton *postApplyButton;

@property (nonatomic, strong) UIView *coverView;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    [self blindViewModel];
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
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.5;
    _coverView.hidden = YES;
    [self.rootView addSubview:_coverView];
    
    //KscreenH - 315 - 20
    self.applyView.frame = CGRectMake( 0, KscreenH, KscreenW, 315);
    [self.rootView addSubview:self.applyView];
    
    self.userNameInput.layer.borderWidth = 1;
    self.userNameInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.telInput.layer.borderWidth = 1;
    self.telInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.resumeInput.layer.borderWidth = 1;
    self.resumeInput.delegate = self;
    self.resumeInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
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
#pragma mark - blind methods

- (void)blindViewModel{
    @weakify(self);
    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,userName)
     options:NSKeyValueObservingOptionNew
     block:^(TSInviteDetailViewController *observer, TSInviteDetailViewModel *object, NSDictionary *change) {
//        @strongify(self);
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.userNameInput.text = change[NSKeyValueChangeNewKey];
         }
    }];
    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,userTel)
     options:NSKeyValueObservingOptionNew
     block:^(TSInviteDetailViewController *observer, TSInviteDetailViewModel *object, NSDictionary *change) {
//         @strongify(self);
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.telInput.text = change[NSKeyValueChangeNewKey];
         }
     }];

    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,userDes)
     options:NSKeyValueObservingOptionNew
     block:^(TSInviteDetailViewController *observer, TSInviteDetailViewModel *object, NSDictionary *change) {
//         @strongify(self);
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.resumeInput.text = change[NSKeyValueChangeNewKey];
         }
     }];

}
- (void)blindActionHandler{

    @weakify(self);

    [self.userNameInput bk_addEventHandler:^(UITextField *textField) {
        @strongify(self);
        [self.viewModel setUserName:textField.text];
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.telInput bk_addEventHandler:^(UITextField *textField) {
        @strongify(self);
        [self.viewModel setUserTel:textField.text];
    } forControlEvents:UIControlEventEditingChanged];
    
    //职位简介
    [self.postInfoButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectedLabel.frame = CGRectMake( 0, 27, KscreenW/2, 2);
        self.postInfoButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.companyInfoButton.backgroundColor = [UIColor whiteColor];
        
        [self.rootView bringSubviewToFront:self.postView];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    //公司简介
    [self.companyInfoButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectedLabel.frame = CGRectMake( KscreenW/2, 27, KscreenW/2, 2);
        self.companyInfoButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.postInfoButton.backgroundColor = [UIColor whiteColor];
        
        [self.rootView bringSubviewToFront:self.companyView];

    } forControlEvents:UIControlEventTouchUpInside];
    
    //拨打电话
    [self.telButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.viewModel.comanyModel.companyTelPhone]]];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //申请职位
    [self.applyButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            CGRect frame = self.applyView.frame;
            frame.origin.y = KscreenH - 315 - 20;
            self.applyView.frame = frame;
        } completion:^(BOOL finished) {
            self.coverView.hidden = NO;
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //举报
    [self.reportButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSUserModel *userModel = [TSUserModel getCurrentLoginUser];

        NSDictionary *params = @{@"reportContent":@"",
                                 @"userId":[NSString stringWithFormat:@"%d",userModel.userId],
                                 @"reportType":@"POST",
                                 @"reportId":[NSString stringWithFormat:@"%d",self.viewModel.postID]};
        [TSHttpTool getWithUrl:Invite_PostRepor_URL params:params withCache:NO success:^(id result) {
            if( [result[@"success"] intValue] == 1 ){
                [self showProgressHUD:@"举报成功" delay:1];
            }else if ([result[@"success"] intValue] == 0 && [result[@"errorMsg"] isEqualToString:@"have_report"]){
                [self showProgressHUD:@"已经举报过" delay:1];
            };

        } failure:^(NSError *error) {
            NSLog(@"举报：%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //投递简历
    [self.postApplyButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSUserModel *userModel = [TSUserModel getCurrentLoginUser];

        NSDictionary *params = @{@"userId": [NSString stringWithFormat:@"%d",userModel.userId],
                                 @"postId": [NSString stringWithFormat:@"%d",self.viewModel.postID],
                                 @"des" : self.viewModel.userDes,
                                 @"telPhone" : self.viewModel.userTel,
                                 @"name": self.viewModel.userName};
        [TSHttpTool postWithUrl:Invite_PostApply_URL params:params success:^(id result) {
            NSLog(@"投递简历:%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"投递简历成功" delay:1];
                [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                    CGRect frame = self.applyView.frame;
                    frame.origin.y = KscreenH;
                    self.applyView.frame = frame;
                    self.coverView.hidden = YES;
                } completion:nil];
            }else if ([result[@"success"] intValue] == 0 && [result[@"errorMsg"] isEqualToString:@"have_ask"]){
                [self showProgressHUD:@"已经申请过" delay:1];
            }
        } failure:^(NSError *error) {
            NSLog(@"投递简历:%@",error);
        }];
/*
         userId 用户Id
         postId 岗位id
         des自我描述
         telPhone  申请人电话
         name 申请人姓名
         如果result.success为true 申请成功
         如果为false  如果result.errorMsg='have_ask' 已经申请过了
*/
    } forControlEvents:UIControlEventTouchUpInside];
    
    //收起弹框
    [self.coverView bk_whenTapped:^{

        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            CGRect frame = self.applyView.frame;
            frame.origin.y = KscreenH;
            self.applyView.frame = frame;
            self.coverView.hidden = YES;

        } completion:nil];

    }];
}

#pragma mark - UITextView delegate

- (void)textViewDidChange:(UITextView *)textView{
    [self.viewModel setUserDes:textView.text];
}
#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:-keyboardRect.size.height + 60 withDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];

    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height - 60 withDuration:animationDuration];
}


- (void)moveInputBarWithKeyboardHeight:(CGFloat)height withDuration:(CGFloat)animationDuration{
    
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect frame = self.rootView.frame;
        frame.origin.y += height;
        self.rootView.frame = frame;
    }];
}

@end
