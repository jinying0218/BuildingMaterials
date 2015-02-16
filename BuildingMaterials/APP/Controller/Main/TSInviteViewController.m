//
//  TSInviteViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSInviteViewController.h"
#import "TSInviteModel.h"
#import "TSInviteCell.h"
#import "MJRefresh.h"
#import "TSInviteCategoryModel.h"
#import "TSInviteCategoryCell.h"

#import "TSInviteDetailViewController.h"
#import "TSInviteDetailViewModel.h"

static NSString * const inviteCellIdentifier = @"inviteCell";
static NSString * const inviteCategoryCellIdentifier = @"inviteCategoryCell";

#define inviteTableViewTag 1000
#define categoryTableViewTag 1001

@interface TSInviteViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *inviteTableView;
@property (strong, nonatomic) UITableView *categoryTableView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) UIButton *categoryButton;
@property (nonatomic, strong) UIButton *naviRightBtn;
@property (nonatomic, strong) UIView *coverTop;
@property (nonatomic, strong) UIView *coverBottom;
@property (nonatomic, strong) UIImageView *selectView;

@end

@implementation TSInviteViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initializData];
    [self blindActionHandler];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializData{

    self.page = 1;
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
    [TSHttpTool getWithUrl:Invite_URL params:params withCache:NO success:^(id result) {
        NSLog(@"招聘:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneResult in result[@"result"]) {
                TSInviteModel *model = [[TSInviteModel alloc] init];
                [model setValueForDictionary:oneResult];
                [self.viewModel.dataArray addObject:model];
            }
            [self.inviteTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"分类:%@",error);
    }];
    
    [TSHttpTool getWithUrl:Invite_Category_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"招聘类别:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneCategory in result[@"result"]) {
                TSInviteCategoryModel *model = [[TSInviteCategoryModel alloc] init];
                [model setValueForDictionary:oneCategory];
                [self.viewModel.categoryDataArray addObject:model];
            }
            TSInviteCategoryModel *model = [[TSInviteCategoryModel alloc] init];
            model.postClassifyName = @"全部";
            [self.viewModel.categoryDataArray insertObject:model atIndex:0];
            [self.categoryTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"招聘类别:%@",error);
    }];
    
}

#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"贵州建材网\nwww.xxx.com" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    UIView *searchBg = [[UIView alloc] initWithFrame:CGRectMake( 10, 8, KscreenW - 80, 28)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.layer.cornerRadius = 5;
    [self.navigationBar addSubview:searchBg];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"search_leftView"]];
    leftView.frame = CGRectMake( 10, 4, 20, 20);
    [searchBg addSubview:leftView];
    
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake( CGRectGetMaxX(leftView.frame) + 10, 0, searchBg.frame.size.width - 40, 28)];
    self.searchTextField.placeholder = @"请输入招聘的职位";
    self.searchTextField.backgroundColor = [UIColor clearColor];
    [searchBg addSubview:self.searchTextField];
    
    self.naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviRightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.naviRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.naviRightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.naviRightBtn.frame = CGRectMake( CGRectGetMaxX(searchBg.frame) + 10, 12, 60, 20);
    [self.navigationBar addSubview:self.naviRightBtn];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake( 0, CGRectGetMaxY(self.navigationBar.frame), KscreenW, 35);
    headerView.layer.borderWidth = 1;
    headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.rootView addSubview:headerView];
    
    self.categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.categoryButton setTitle:@"类别" forState:UIControlStateNormal];
    [self.categoryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.categoryButton setImage:[UIImage imageNamedString:@"select_icon"] forState:UIControlStateNormal];
    self.categoryButton.frame = CGRectMake( 0, 0, KscreenW, 34);
    [headerView addSubview:self.categoryButton];
    
    self.selectView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"select_icon"]];
    self.selectView.frame = CGRectMake( headerView.frame.size.width - 30, headerView.frame.size.height/2 - 5, 12, 8);
    [headerView addSubview:self.selectView];
    
    self.inviteTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 79, KscreenW, KscreenH - KbottomBarHeight - 64 - 35) style:UITableViewStylePlain];
    self.inviteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.inviteTableView.rowHeight = 80;
//    self.inviteTableView.backgroundColor = [UIColor yellowColor];
    self.inviteTableView.tag = inviteTableViewTag;
    [self.rootView addSubview:self.inviteTableView];
    self.inviteTableView.delegate = self;
    self.inviteTableView.dataSource = self;
    
    //集成下拉刷新
    [self.inviteTableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    self.inviteTableView.headerPullToRefreshText = @"下拉刷新";
    self.inviteTableView.headerReleaseToRefreshText = @"松开马上加载更多数据";
    self.inviteTableView.headerRefreshingText = @"加载中……";
    
    //集成上拉加载更多
    [self.inviteTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.inviteTableView.footerPullToRefreshText = @"上拉加载更多";
    self.inviteTableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.inviteTableView.footerRefreshingText = @"加载中……";
    
    self.coverTop = [[UIView alloc] init];
    self.coverTop.frame = CGRectMake( 0, 0, KscreenW, 44);
    self.coverTop.backgroundColor = [UIColor blackColor];
    self.coverTop.alpha = 0.5;
    self.coverTop.hidden = YES;
    [self.rootView addSubview:self.coverTop];
    
    self.coverBottom = [[UIView alloc] init];
    self.coverBottom.frame = CGRectMake( 0, 79, KscreenW, KscreenH);
    self.coverBottom.backgroundColor = [UIColor blackColor];
    self.coverBottom.alpha = 0.5;
    self.coverBottom.hidden = YES;
    [self.rootView addSubview:self.coverBottom];
    
    self.categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 99, KscreenW, 44 * 5) style:UITableViewStylePlain];
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.categoryTableView.rowHeight = 44;
    self.categoryTableView.tag = categoryTableViewTag;
    [self.rootView addSubview:self.categoryTableView];
    [self.view addSubview:self.categoryTableView];
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.categoryTableView.showsVerticalScrollIndicator = NO;
    self.categoryTableView.hidden = YES;

}

- (void)blindActionHandler{
    @weakify(self);
    [self.naviRightBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        
        NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page],
                       @"postSearchName":self.searchTextField.text};
        
        [TSHttpTool getWithUrl:Invite_URL params:params withCache:NO success:^(id result) {
            //            NSLog(@"招聘类别:%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self.viewModel.dataArray removeAllObjects];
                for (NSDictionary *oneResult in result[@"result"]) {
                    TSInviteModel *model = [[TSInviteModel alloc] init];
                    [model setValueForDictionary:oneResult];
                    [self.viewModel.dataArray addObject:model];
                }
                [self.inviteTableView reloadData];
            }
        } failure:^(NSError *error) {
            NSLog(@"分类:%@",error);
        }];

    } forControlEvents:UIControlEventTouchUpInside];
    

    [self.categoryButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.categoryTableView.hidden = !self.categoryTableView.hidden;
        self.coverTop.hidden = !self.coverTop.hidden;
        self.coverBottom.hidden = !self.coverBottom.hidden;
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 下拉刷新
- (void)headerRefreshing{
    self.page = 1;
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
    [TSHttpTool getWithUrl:Invite_URL params:params withCache:NO success:^(id result) {
        NSLog(@"招聘:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.dataArray removeAllObjects];
            for (NSDictionary *oneResult in result[@"result"]) {
                TSInviteModel *model = [[TSInviteModel alloc] init];
                [model setValueForDictionary:oneResult];
                [self.viewModel.dataArray addObject:model];
            }
            [self.inviteTableView reloadData];
            [self.inviteTableView headerEndRefreshing];
        }
    } failure:^(NSError *error) {
        NSLog(@"分类:%@",error);
    }];
    
}

#pragma mark - 上拉加载更多
- (void)footerRereshing{
    self.page += 1;
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
    [TSHttpTool getWithUrl:Invite_URL params:params withCache:NO success:^(id result) {
//                NSLog(@"招聘:%d--%@",self.page,result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneResult in result[@"result"]) {
                TSInviteModel *model = [[TSInviteModel alloc] init];
                [model setValueForDictionary:oneResult];
                [self.viewModel.dataArray addObject:model];
            }
            [self.inviteTableView reloadData];
            [self.inviteTableView footerEndRefreshing];

        }
    } failure:^(NSError *error) {
        NSLog(@"分类:%@",error);
    }];

}
#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag == inviteTableViewTag) {
        return self.viewModel.dataArray.count;
    }else {
        return self.viewModel.categoryDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == inviteTableViewTag) {
        TSInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:inviteCellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInviteCell" owner:nil options:nil]lastObject];
        }
        
        TSInviteModel *model = self.viewModel.dataArray[indexPath.row];
        [cell configureCellWithModel:model];
        return cell;

    }else {
        TSInviteCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:inviteCategoryCellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInviteCategoryCell" owner:nil options:nil]lastObject];
        }

        TSInviteCategoryModel *model = self.viewModel.categoryDataArray[indexPath.row];
        cell.categoryDes.text = model.postClassifyName;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == categoryTableViewTag) {
        self.categoryTableView.hidden = YES;
        self.coverBottom.hidden = YES;
        self.coverTop.hidden = YES;
        self.page = 1;
        TSInviteCategoryModel *categoryModel = self.viewModel.categoryDataArray[indexPath.row];
        NSDictionary *params;
        if (indexPath.row == 0) {
            params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
        }else {
            params = @{@"page":[NSString stringWithFormat:@"%d",self.page],
                       @"postClassifyId":[NSString stringWithFormat:@"%d",categoryModel.categoryID]};
        }

        [TSHttpTool getWithUrl:Invite_URL params:params withCache:NO success:^(id result) {
//            NSLog(@"招聘类别:%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self.viewModel.dataArray removeAllObjects];
                for (NSDictionary *oneResult in result[@"result"]) {
                    TSInviteModel *model = [[TSInviteModel alloc] init];
                    [model setValueForDictionary:oneResult];
                    [self.viewModel.dataArray addObject:model];
                }
                [self.inviteTableView reloadData];
            }
        } failure:^(NSError *error) {
            NSLog(@"分类:%@",error);
        }];
    }else if (tableView.tag == inviteTableViewTag){
        [self.tabBarController hidesBottomBarWhenPushed];
        TSInviteModel *model = self.viewModel.dataArray[indexPath.row];
        TSInviteDetailViewModel *viewModel = [[TSInviteDetailViewModel alloc] init];
        viewModel.postID = model.I_D;
        TSInviteDetailViewController *inviteDetailVC = [[TSInviteDetailViewController alloc] init];
        inviteDetailVC.viewModel = viewModel;
        [self.navigationController pushViewController:inviteDetailVC animated:YES];
    }
}
@end
