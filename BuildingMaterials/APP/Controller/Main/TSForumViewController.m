//
//  TSForumViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSForumViewController.h"
#import <UIImageView+WebCache.h>
#import "TSForumModel.h"
#import "TSForumTableViewCell.h"
#import "TSForumClassifyDetailViewController.h"

static NSString *const ForumTableViewCellIdentifier = @"ForumTableViewCellIdentifier";

@interface TSForumViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSForumViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailizeData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initailizeData{
    [TSHttpTool getWithUrl:Forum_URL params:nil withCache:NO success:^(id result) {
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSForumModel *forumModel = [[TSForumModel alloc] init];
                [forumModel setValueWithDict:dict];
                [self.viewModel.dataArray addObject:forumModel];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"论坛：%@",error);
    }];
}

#pragma mark - set UI
- (void)setupUI{
    
//    [self creatRootView];
    [self createNavigationBarTitle:@"论坛栏目" leftButtonImageName:nil rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSForumTableViewCell" owner:nil options:nil]lastObject];
    }
    TSForumModel *model = self.viewModel.dataArray[indexPath.row];
//    [cell configureCellWithModel:model];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.forumClassifyImage] placeholderImage:[UIImage imageNamed:@"not_load"]];
    cell.forumName.text = model.forumClassifyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TSForumModel *model = self.viewModel.dataArray[indexPath.row];
    TSForumClassifyDetailViewController *forumDetailVC = [[TSForumClassifyDetailViewController alloc] init];
    forumDetailVC.forumClassifyName = model.forumClassifyName;
    forumDetailVC.forumClassifyId = model.forumClassifyID;
    forumDetailVC.forumClassifyImageURL = model.forumClassifyImage2;
    [self.navigationController pushViewController:forumDetailVC animated:YES];
}

@end
