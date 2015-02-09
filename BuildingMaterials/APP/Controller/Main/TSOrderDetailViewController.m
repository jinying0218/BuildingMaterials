//
//  TSOrderDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderDetailViewController.h"
#import "TSOrderDetailViewModel.h"
#import "TSUserModel.h"
#import "TSOrderDetailTableViewCell.h"
#import "TSOrderDetailGoodsModel.h"

static NSString *const OrderDetailTableViewCellIdendifier = @"OrderDetailTableViewCellIdendifier";

@interface TSOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSOrderDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextField *commentInput;
@property (weak, nonatomic) IBOutlet UIButton *postCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelCommentButton;
@property (nonatomic, assign) CGFloat popHeight;
@property (nonatomic, strong) NSIndexPath *commentIndexPath;
@property (nonatomic, strong) TSUserModel *userModel;
@end

@implementation TSOrderDetailViewController
- (instancetype)initWithViewModel:(TSOrderDetailViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
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
    self.userModel = [TSUserModel getCurrentLoginUser];

    NSDictionary *params = @{@"orderId" : [NSString stringWithFormat:@"%d",self.viewModel.orderId]};
    [TSHttpTool getWithUrl:OrderDetail_URL params:params withCache:NO success:^(id result) {
//                NSLog(@"订单详情:%@",result);
      if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSOrderDetailGoodsModel *orderGoodsModel = [[TSOrderDetailGoodsModel alloc] init];
                [orderGoodsModel modelWithDict:dict];
                [self.viewModel.dataArray addObject:orderGoodsModel];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"待付款订单:%@",error);
    }];
/* */
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;
    
    [self createNavigationBarTitle:@"订单详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.commentView.frame = CGRectMake( 0, self.view.frame.size.height, self.view.frame.size.width, 90);
    [self.view addSubview:self.commentView];
    
    
}

- (void)blindViewModel{
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,commentContentString)
     options:NSKeyValueObservingOptionNew
     block:^(TSOrderDetailViewController *observer, TSOrderDetailViewModel *object, NSDictionary *change) {
         //         @strongify(self);
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.commentInput.text = change[NSKeyValueChangeNewKey];
         }
     }];

}
- (void)blindActionHandler{
    @weakify(self);
    [self.commentInput bk_addEventHandler:^(UITextField *commentInput) {
        @strongify(self);
        [self.viewModel setCommentContentString:commentInput.text];
        [self.view resignFirstResponder];
    } forControlEvents:UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
    
    [self.postCommentButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.commentInput resignFirstResponder];
        if ([self.viewModel.commentContentString isEqualToString:@""] ||
            !self.viewModel.commentContentString) {
            [self showProgressHUD:@"请填写评论" delay:1];
            return ;
        }
        TSOrderDetailGoodsModel *goodsModel = self.viewModel.dataArray[self.commentIndexPath.row];
        NSDictionary *params = @{@"goodsId" : [NSString stringWithFormat:@"%d",goodsModel.goodsId],
                                 @"commentContent" : self.viewModel.commentContentString,
                                 @"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
        [TSHttpTool postWithUrl:PostGoodsComment_URL params:params success:^(id result) {
            NSLog(@"%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"评论成功" delay:1];
                self.commentInput.text = @"";
                [self.commentInput resignFirstResponder];
            }else if ([result[@"errorMsg"] isEqualToString:@"have_comment"]){
                [self showProgressHUD:@"不可以重复评论哦亲" delay:1];
                self.commentInput.text = @"";
                [self.commentInput resignFirstResponder];
            }
        } failure:^(NSError *error) {
            
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.cancelCommentButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.commentInput resignFirstResponder];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSOrderDetailTableViewCell" owner:nil options:nil]lastObject];
    }
    if (![self.viewModel.orderStatus isEqualToString:@"HAVE_GET"]) {
        cell.commentGoodsButton.enabled = YES;
    }
    cell.indexPath = indexPath;
    TSOrderDetailGoodsModel *orderGoodsModel = self.viewModel.dataArray[indexPath.row];
    @weakify(self);
    [cell configureCell:orderGoodsModel commentButtonHandler:^(NSIndexPath *indexPath){
       //评论按钮
        @strongify(self);
        self.commentIndexPath = indexPath;
        [self.commentInput becomeFirstResponder];
    }];
    return cell;
}

- (void)showCommentView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.commentView.frame;
        frame.origin.y = self.view.frame.size.height - 90;
        self.commentView.frame = frame;
    }];
}
- (void)hideCommentView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.commentView.frame;
        frame.origin.y = self.view.frame.size.height;
        self.commentView.frame = frame;
    }];
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
    if (self.commentView.frame.origin.y >= self.view.frame.size.height) {
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
        CGRect frame = self.commentView.frame;
        frame.origin.y += height;
        self.commentView.frame = frame;
    }];
}

@end
