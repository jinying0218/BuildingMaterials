//
//  TSHavePayedViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSHavePayedViewController.h"
#import "TSHavePayedViewModel.h"
#import "TSHavePayedTableViewCell.h"
#import "TSWaitOrderModel.h"
#import "TSUserModel.h"
#import "TSOrderDetailGoodsModel.h"
#import "TSOrderDetailViewController.h"
#import "TSOrderDetailViewModel.h"

static NSString *const HavePayedTableViewCellIdendifier = @"HavePayedTableViewCellIdendifier";

@interface TSHavePayedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSHavePayedViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *askBackView;
@property (strong, nonatomic) IBOutlet UIView *checkTransportView;
@property (weak, nonatomic) IBOutlet UITextField *reasonInput;
@property (weak, nonatomic) IBOutlet UIButton *confirmAskBackButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelAskBackButton;
@property (weak, nonatomic) IBOutlet UILabel *transportName;
@property (weak, nonatomic) IBOutlet UILabel *tansportCode;
@property (weak, nonatomic) IBOutlet UIButton *cancelCheckTransportButton;
@property (nonatomic, assign) CGFloat popHeight;
@property (nonatomic, strong) NSIndexPath *askBackIndexPath;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end

@implementation TSHavePayedViewController
- (instancetype)initWithViewModel:(TSHavePayedViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)dealloc{
    [self.reasonInput resignFirstResponder];
    [self.askBackView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardWillShow:)
                                                 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardWillHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];

    
    [self initializeData];
    [self configureUI];
    [self blindViewModel];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData{
    TSUserModel *userModel = [TSUserModel getCurrentLoginUser];
    NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",userModel.userId]};
    [TSHttpTool getWithUrl:WaitForPay_URL params:params withCache:NO success:^(id result) {
                NSLog(@"待付款订单:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSWaitOrderModel *orderModel = [[TSWaitOrderModel alloc] init];
                [orderModel modelWithDict:dict];
//                if ([orderModel.orderStatus isEqualToString:@"TIME_OVER"]) {
//                    [self.viewModel.dataArray addObject:orderModel];
//                }
                [self.viewModel.dataArray addObject:orderModel];

            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"待付款订单:%@",error);
    }];

}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;
    
    [self createNavigationBarTitle:@"已付订单" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.askBackView.frame = CGRectMake( 0, KscreenH, KscreenW, 90);
    [[UIApplication sharedApplication].keyWindow addSubview:self.askBackView];

    self.checkTransportView.frame = CGRectMake( 0, KscreenH, KscreenW, 90);
    [self.view addSubview:self.checkTransportView];

}

- (void)blindViewModel{
    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,reasonString)
     options:NSKeyValueObservingOptionNew
     block:^(TSHavePayedViewController *observer, TSHavePayedViewModel *object, NSDictionary *change) {
         //         @strongify(self);
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.reasonInput.text = change[NSKeyValueChangeNewKey];
         }
     }];

}
- (void)blindActionHandler{
    
    @weakify(self);
    [self.reasonInput bk_addEventHandler:^(UITextField *commentInput) {
        @strongify(self);
        [self.viewModel setReasonString:commentInput.text];
        [self.reasonInput resignFirstResponder];
    } forControlEvents:UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
    
    [self.confirmAskBackButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.reasonInput resignFirstResponder];
        if ([self.viewModel.reasonString isEqualToString:@""] ||
            !self.viewModel.reasonString) {
            [self showProgressHUD:@"请填写退货原因" delay:1];
            return ;
        }
        TSWaitOrderModel *orderModel = self.viewModel.dataArray[self.askBackIndexPath.row];
        NSDictionary *params = @{@"orderId" : [NSString stringWithFormat:@"%d",orderModel.orderId],
                                 @"backReason" : self.viewModel.reasonString};
        [TSHttpTool postWithUrl:PostGoodsComment_URL params:params success:^(id result) {
            NSLog(@"退款结果：%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"退款成功" delay:1];
                self.reasonInput.text = @"";
                [self.reasonInput resignFirstResponder];
                self.coverView.hidden = YES;
                self.askBackView.hidden = YES;
            }
            /*
            else if ([result[@"errorMsg"] isEqualToString:@"have_comment"]){
                [self showProgressHUD:@"不可以重复评论哦亲" delay:1];
                self.commentInput.text = @"";
                [self.commentInput resignFirstResponder];
            }
             */
        } failure:^(NSError *error) {
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelAskBackButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.reasonInput resignFirstResponder];
        self.coverView.hidden = YES;
        self.askBackView.hidden = YES;
    } forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSHavePayedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HavePayedTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSHavePayedTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.indexPath = indexPath;
    TSWaitOrderModel *orderModel = self.viewModel.dataArray[indexPath.row];
    @weakify(self);
    [cell configureCell:orderModel orderDetailButtonHandler:^(NSIndexPath *indexPath) {
        //订单详情
        @strongify(self);
        TSWaitOrderModel *currentOrderModel = self.viewModel.dataArray[indexPath.row];
        TSOrderDetailViewModel *viewModel = [[TSOrderDetailViewModel alloc] init];
        viewModel.orderId = currentOrderModel.orderId;
        TSOrderDetailViewController *orderDetailVC = [[TSOrderDetailViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:orderDetailVC animated:YES];

    } moneyBackButtonHandler:^(NSIndexPath *indexPath) {
        //申请退款
        @strongify(self);
        self.askBackIndexPath = indexPath;
        self.coverView.hidden = NO;
        self.askBackView.hidden = NO;
        [self.reasonInput becomeFirstResponder];
    } checkTransportButtonHandler:^(NSIndexPath *indexPath) {
        //查看物流
        @strongify(self);
        
    } confirmReceiveButtonHandler:^(NSIndexPath *indexPath) {
        //确认收货
        @strongify(self);
        
    }];
    return cell;
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
    if (self.askBackView.frame.origin.y >= self.view.frame.size.height) {
        self.popHeight = keyboardRect.size.height + 90;
    }else {
        self.popHeight = keyboardRect.size.height;
    }
    [self moveInputBarWithKeyboardHeight:-self.popHeight withDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}
- (void)moveInputBarWithKeyboardHeight:(CGFloat)height withDuration:(CGFloat)animationDuration{
    
    [UIView animateWithDuration:0 animations:^{
        CGRect frame = self.askBackView.frame;
        frame.origin.y += height;
        self.askBackView.frame = frame;
    }];
}

@end
