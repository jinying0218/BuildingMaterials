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
@property (strong, nonatomic) IBOutlet UIScrollView *postView;

@property (weak, nonatomic) IBOutlet UILabel *postName;
@property (weak, nonatomic) IBOutlet UILabel *postTime;
@property (weak, nonatomic) IBOutlet UILabel *postAskNumber;
@property (weak, nonatomic) IBOutlet UILabel *postPrice;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *postNumber;
@property (weak, nonatomic) IBOutlet UILabel *companyAddress;
@property (weak, nonatomic) IBOutlet UILabel *postDes;
@property (weak, nonatomic) IBOutlet UILabel *postHeart;
@property (weak, nonatomic) IBOutlet UIView *postNameView;      //岗位信息，包括岗位名称

@property (weak, nonatomic) IBOutlet UIView *postDesView;   //岗位描述的view
@property (weak, nonatomic) IBOutlet UIView *companyInfoView;   //岗位公司信息
@property (weak, nonatomic) IBOutlet UIView *tipView;
//小贴士
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
@property (weak, nonatomic) IBOutlet UIButton *cancelApplyButton;

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
//        NSLog(@"招聘详情：%@",result);
        if ([result[@"success"] intValue] == 1) {
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
    
    [self createNavigationBarTitle:@"招聘详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];

    
    self.headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headerView.layer.borderWidth = 1;
    
//    self.companyView.frame = CGRectMake( 0, 0, KscreenW, KscreenH - 64 - 30 - 60);
//    [self.rootScrollView addSubview:self.companyView];
    
//    self.postView.frame = CGRectMake( 0, 0, KscreenW, KscreenH - STATUS_BAR_HEGHT - KnaviBarHeight - 60 - 30);
//    self.postView.backgroundColor = [UIColor clearColor];
//    [self.rootScrollView addSubview:self.postView];
    
    //设置岗位信息页面 UI排布
//    self.postNameView.frame = CGRectMake( 0, 0, KscreenW, 70);
//    self.companyInfoView.frame = CGRectMake( 0, CGRectGetMaxY(self.postNameView.frame) + 10, KscreenW, 95);
    
    self.postHeart.text = @"凡是扣押证件原件，未标明收费却收取各种费用，要求购买购物卡或者各种商品的，都有诈骗嫌疑";
    
    //底部视图
//    self.bottomView.frame = CGRectMake(0, KscreenH - 60, KscreenW, 60);
//    [self.view addSubview:self.bottomView];
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.5;
    _coverView.hidden = YES;
    [self.view insertSubview:_coverView belowSubview:self.postView];
    
    //KscreenH - 315 - 20
    self.applyView.frame = CGRectMake( 0, self.view.frame.size.height, KscreenW, 315);
    [[UIApplication sharedApplication].keyWindow addSubview:self.applyView];
    
    self.cancelApplyButton.frame = CGRectMake( KscreenW - 22, KscreenH - 315 - 11, 22, 22);
    [[UIApplication sharedApplication].keyWindow addSubview:self.cancelApplyButton];
    
    
    self.userNameInput.layer.borderWidth = 1;
    self.userNameInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.telInput.layer.borderWidth = 1;
    self.telInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.resumeInput.layer.borderWidth = 1;
    self.resumeInput.delegate = self;
    self.resumeInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIView *statusView = [[UIView alloc] init];
    statusView.frame = CGRectMake( 0, 0, KscreenW, 20);
    statusView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statusView];
}

- (void)layoutSubViews{
    self.postName.text = self.viewModel.postModel.postName;
    self.postTime.text = self.viewModel.postModel.postTime;
    self.postAskNumber.text = [NSString stringWithFormat:@"%d",self.viewModel.postModel.postAskNumber];
    self.postDes.text = self.viewModel.postModel.postDes;

    //自适应高度
    CGRect txtFrame = self.postDes.frame;
    
    self.postDes.frame = CGRectMake( 8, 26, KscreenW - 16,
                             txtFrame.size.height =[self.postDes.text boundingRectWithSize:
                                                    CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.postDes.font,NSFontAttributeName, nil] context:nil].size.height);
    
    self.postDes.frame = CGRectMake( 8, 26, KscreenW - 16, txtFrame.size.height);
    self.postDesView.frame = CGRectMake( 0, CGRectGetMaxY(self.companyInfoView.frame) + 10, KscreenW, CGRectGetMaxY(self.postDes.frame) + 5);
    self.tipView.frame = CGRectMake( 0, CGRectGetMaxY(self.postDesView.frame) + 10, KscreenW, 84);
    
    self.reportButton.frame = CGRectMake( 20, CGRectGetMaxY(self.tipView.frame) + 20, KscreenW - 40, 30);
    
    if (CGRectGetMaxY(self.reportButton.frame) + 10 >= self.postView.frame.size.height) {
        self.postView.contentSize = CGSizeMake( KscreenW, CGRectGetMaxY(self.reportButton.frame) + 10);
    }
    
    self.postPrice.text = [NSString stringWithFormat:@"%d 元/月",self.viewModel.postModel.postPrice];
    self.postNumber.text = [NSString stringWithFormat:@"%d",self.viewModel.postModel.postNumber];
    self.companyAddress.text = self.viewModel.comanyModel.companyAddress;
    self.companyName.text = self.viewModel.comanyModel.companyName;
    
    self.companyViewName.text = self.viewModel.comanyModel.companyName;
    self.companyViewAddress.text = self.viewModel.comanyModel.companyAddress;
    self.companyDes.text = self.viewModel.comanyModel.companyDes;
    
    self.contactPerson.text = self.viewModel.comanyModel.companyContact;
    self.telNumber.text = self.viewModel.comanyModel.companyTelPhone;
    
}
#pragma mark - blind methods

- (void)blindViewModel{
//    @weakify(self);
    
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
    } forControlEvents:UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
    
    [self.telInput bk_addEventHandler:^(UITextField *textField) {
        @strongify(self);
        [self.viewModel setUserTel:textField.text];
    } forControlEvents:UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
    
    //职位简介
    [self.postInfoButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectedLabel.frame = CGRectMake( 0, 27, KscreenW/2, 2);
        self.postInfoButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.companyInfoButton.backgroundColor = [UIColor whiteColor];
        self.postView.hidden = NO;
        self.companyView.hidden = YES;
        [self.rootScrollView bringSubviewToFront:self.postView];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    //公司简介
    [self.companyInfoButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectedLabel.frame = CGRectMake( KscreenW/2, 27, KscreenW/2, 2);
        self.companyInfoButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.postInfoButton.backgroundColor = [UIColor whiteColor];
        self.postView.hidden = YES;
        self.companyView.hidden = NO;
        [self.rootScrollView bringSubviewToFront:self.companyView];

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
            frame.origin.y = KscreenH - 315;
            self.applyView.frame = frame;
            self.applyView.hidden = NO;
            self.cancelApplyButton.hidden = NO;
        } completion:^(BOOL finished) {
            self.coverView.hidden = NO;
        }];
        self.applyView.hidden = NO;
        self.cancelApplyButton.hidden = NO;
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
        [TSHttpTool postWithUrl:Invite_PostRepor_URL params:params success:^(id result) {
            NSLog(@"举报:%@",result);
        } failure:^(NSError *error) {
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
                    frame.origin.y = self.rootScrollView.contentSize.height + 44;
                    self.applyView.frame = frame;
                    self.coverView.hidden = YES;
                } completion:nil];
            }else if ([result[@"success"] intValue] == 0 && [result[@"errorMsg"] isEqualToString:@"have_ask"]){
                [self showProgressHUD:@"已经申请过" delay:1];
            }
        } failure:^(NSError *error) {
            NSLog(@"投递简历:%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelApplyButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            CGRect frame = self.applyView.frame;
            frame.origin.y = self.view.frame.size.height + 44;
            self.applyView.frame = frame;
            self.coverView.hidden = YES;
            self.cancelApplyButton.hidden = YES;
        } completion:nil];

    } forControlEvents:UIControlEventTouchUpInside];
    //收起弹框
    
    [self.coverView bk_whenTapped:^{
        [self.view endEditing:YES];
        [self.applyView endEditing:YES];
        self.cancelApplyButton.hidden = YES;
        [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            CGRect frame = self.applyView.frame;
            frame.origin.y = self.view.frame.size.height + 44;
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
        CGRect frame = self.rootScrollView.frame;
        frame.origin.y += height;
        self.rootScrollView.frame = frame;
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.applyView.frame;
        frame.origin.y -= 165;
        self.applyView.frame = frame;
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.applyView.frame;
        frame.origin.y += 165;
        self.applyView.frame = frame;
    }];

}

@end
