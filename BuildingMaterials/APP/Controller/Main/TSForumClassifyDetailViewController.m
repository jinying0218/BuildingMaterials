//
//  TSForumDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSForumClassifyDetailViewController.h"
#import "TSForumClassifyModel.h"
#import "TSForumClassifyTableViewCell.h"
#import "TSForumDetailViewController.h"
#import "TSPublishViewController.h"
#import "TSPublishViewModel.h"
#import "MJRefresh.h"

static NSString *const ForumClassifyTableViewCellIdentifier = @"ForumClassifyTableViewCell";

@interface TSForumClassifyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int forumOrderType;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TSForumClassifyDetailViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView headerBeginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    self.forumOrderType = 1;
    self.page = 1;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
//    [self initailizeData];
    [self setupUI];
    
    [self blindActionHandler];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initailizeData{
    ///// 1 全部  2. 推荐  3. 最新
    [self.dataArray removeAllObjects];
    NSDictionary *params = @{@"forumOrderType" : [NSString stringWithFormat:@"%d",self.forumOrderType],
                             @"forumSearchName" : @"",
                             @"forumClassifyId" : [NSString stringWithFormat:@"%d",self.forumClassifyId],
                             @"page" : [NSString stringWithFormat:@"%d",self.page]};
    [TSHttpTool getWithUrl:ForumClassifyLoad_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"论坛--栏目：%@",result);

        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSForumClassifyModel *model = [[TSForumClassifyModel alloc] init];
                [model setValueWithDict:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"论坛--栏目：%@",error);
    }];
}

#pragma mark - set UI
- (void)setupUI{
    
    //    [self creatRootView];
    [self createNavigationBarTitle:self.forumClassifyName leftButtonImageName:@"Previous" rightButtonImageName:@"navi_pulish_btn"];
    [self.navigationBar addSubview:self.naviRightBtn];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //集成上拉加载更多
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"加载中……";
    
    //集成下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.headerRefreshingText = @"加载中……";

}
#pragma mark - 上拉加载更多
- (void)footerRereshing{
    self.page += 1;
    [self showProgressHUD];
    ///// 1 全部  2. 推荐  3. 最新
    NSDictionary *params = @{@"forumOrderType" : [NSString stringWithFormat:@"%d",self.forumOrderType],
                             @"forumSearchName" : @"",
                             @"forumClassifyId" : [NSString stringWithFormat:@"%d",self.forumClassifyId],
                             @"page" : [NSString stringWithFormat:@"%d",self.page]};
    [TSHttpTool getWithUrl:ForumClassifyLoad_URL params:params withCache:NO success:^(id result) {
        //        NSLog(@"论坛--栏目：%@",result);
        [self hideProgressHUD];

        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSForumClassifyModel *model = [[TSForumClassifyModel alloc] init];
                [model setValueWithDict:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];

        }
    } failure:^(NSError *error) {
        [self hideProgressHUD];
        NSLog(@"论坛--栏目：%@",error);
    }];
    
}

- (void)headerRefreshing{
    self.page = 1;
    ///// 1 全部  2. 推荐  3. 最新
    [self.dataArray removeAllObjects];
    NSDictionary *params = @{@"forumOrderType" : [NSString stringWithFormat:@"%d",self.forumOrderType],
                             @"forumSearchName" : @"",
                             @"forumClassifyId" : [NSString stringWithFormat:@"%d",self.forumClassifyId],
                             @"page" : [NSString stringWithFormat:@"%d",self.page]};
    [self showProgressHUD];
    [TSHttpTool getWithUrl:ForumClassifyLoad_URL params:params withCache:NO success:^(id result) {
        //        NSLog(@"论坛--栏目：%@",result);
        [self hideProgressHUD];
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSForumClassifyModel *model = [[TSForumClassifyModel alloc] init];
                [model setValueWithDict:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }
    } failure:^(NSError *error) {
        [self hideProgressHUD];
        NSLog(@"论坛--栏目：%@",error);
    }];

}

- (void)blindActionHandler{
    @weakify(self);
    [self.segmentView bk_addEventHandler:^(UISegmentedControl *segment) {
        @strongify(self);
        switch (segment.selectedSegmentIndex) {
            case 0:{
                self.forumOrderType = 1;
            }
                break;
            case 1:{
                self.forumOrderType = 3;    //推荐
            }
                break;
            case 2:{
               self.forumOrderType = 2;     //最新
            }
                break;
   
            default:
                break;
        }
        [self initailizeData];
    } forControlEvents:UIControlEventValueChanged];
    
    [self.naviRightBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSPublishViewModel *viewModel = [[TSPublishViewModel alloc] init];
        viewModel.forumClassifyId = self.forumClassifyId;
        TSPublishViewController *publishVC = [[TSPublishViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:publishVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSForumClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumClassifyTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSForumClassifyTableViewCell" owner:nil options:nil]lastObject];
    }
    TSForumClassifyModel *model = self.dataArray[indexPath.row];
    cell.contentTitle.text = model.forum_content_title;
    cell.contentTime.text = model.forum_content_time;
    cell.forumUser.text = model.forum_user;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TSForumModel *model = self.viewModel.dataArray[indexPath.row];
//    TSForumDetailViewController *forumDetailVC = [[TSForumDetailViewController alloc] init];
//    forumDetailVC.forumClassifyName = model.forumClassifyName;
//    forumDetailVC.forumClassifyId = model.forumClassifyID;
//    [self.navigationController pushViewController:forumDetailVC animated:YES];
    
    TSForumDetailViewController *forumDetailVC = [[TSForumDetailViewController alloc] init];
    TSForumClassifyModel *model = self.dataArray[indexPath.row];
    forumDetailVC.forumClassifyModel = model;
    forumDetailVC.forumClassifyImageURL = self.forumClassifyImageURL;
    [self.navigationController pushViewController:forumDetailVC animated:YES];
}

@end
