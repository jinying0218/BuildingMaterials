//
//  TSReplyViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/24.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSReplyViewController.h"
#import "TSReplyTableViewCell.h"
#import "TSReplyModel.h"
#import "TSUserModel.h"

static NSString *const ReplyTableViewCellIdentifier = @"ReplyTableViewCellIdentifier";

@interface TSReplyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UITextView *replyInput;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TSUserModel *userModel;
@end

@implementation TSReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.page = 1;
    self.userModel = [TSUserModel getCurrentLoginUser];
    
    
    [self initailizeData];
    [self setupUI];

    [self blindActionHandler];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initailizeData{
    [self.dataArray removeAllObjects];
    NSDictionary *params = @{@"forumId" : [NSString stringWithFormat:@"%d",self.forumId],
                             @"page" : [NSString stringWithFormat:@"%d",self.page]};
    [TSHttpTool getWithUrl:ForumComment_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"帖子回复:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSReplyModel *model = [[TSReplyModel alloc] init];
                [model setValueWithDict:dict];
                NSRange range = NSMakeRange(3, 4);
                [model.commentName replaceCharactersInRange:range withString:@"****"];
                [self.dataArray addObject: model];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"帖子回复:%@",error);
    }];
}
#pragma mark - set UI
- (void)setupUI{
    [self createNavigationBarTitle:@"帖子回复" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.replyInput.delegate = self;
}
- (void)blindActionHandler{
    @weakify(self);
    [self.replyButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSDictionary *params = @{@"commentContent" : self.replyInput.text,
                                 @"forumId" : [NSString stringWithFormat:@"%d",self.forumId],
                                 @"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
        [TSHttpTool postWithUrl:CommentPost_URL params:params success:^(id result) {
//            NSLog(@"发表回复：%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"回复成功" delay:1];
                self.replyInput.text = @"";
                [self.view endEditing:YES];
                [self initailizeData];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"发表回复：%@",error);
        }];
        
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - tableView delegate & dataSource
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReplyTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSReplyTableViewCell" owner:nil options:nil]lastObject];
    }
    TSReplyModel *model = self.dataArray[indexPath.row];
    [cell configureCell:model indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    TSForumModel *model = self.viewModel.dataArray[indexPath.row];
    //    TSForumDetailViewController *forumDetailVC = [[TSForumDetailViewController alloc] init];
    //    forumDetailVC.forumClassifyName = model.forumClassifyName;
    //    forumDetailVC.forumClassifyId = model.forumClassifyID;
    //    [self.navigationController pushViewController:forumDetailVC animated:YES];
    
//    TSForumDetailViewController *forumDetailVC = [[TSForumDetailViewController alloc] init];
//    TSForumClassifyModel *model = self.dataArray[indexPath.row];
//    forumDetailVC.forumClassifyModel = model;
//    [self.navigationController pushViewController:forumDetailVC animated:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.bottomView.frame;
        frame.origin.y -= 272;
        self.bottomView.frame = frame;
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.bottomView.frame;
        frame.origin.y += 272;
        self.bottomView.frame = frame;
    }];

}


@end
