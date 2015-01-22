//
//  TSForumDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSForumDetailViewController.h"
#import "TSForumClassifyModel.h"
#import "TSForumClassifyTableViewCell.h"

static NSString *const ForumClassifyTableViewCellIdentifier = @"ForumClassifyTableViewCell";

@interface TSForumDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int forumOrderType;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TSForumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    
    self.forumOrderType = 1;
    self.page = 1;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self initailizeData];
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
       // NSLog(@"论坛--栏目：%@",result);

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
    [self createNavigationBarTitle:self.forumClassifyName leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
                self.forumOrderType = 2;
            }
                break;
            case 2:{
               self.forumOrderType = 3;
            }
                break;
   
            default:
                break;
        }
        [self initailizeData];
    } forControlEvents:UIControlEventValueChanged];
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
    cell.textLabel.text = model.forum_content_title;
    //    [cell configureCellWithModel:model];
//    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.forumClassifyImage] placeholderImage:[UIImage imageNamed:@"not_load"]];
//    cell.forumName.text = model.forumClassifyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TSForumModel *model = self.viewModel.dataArray[indexPath.row];
//    TSForumDetailViewController *forumDetailVC = [[TSForumDetailViewController alloc] init];
//    forumDetailVC.forumClassifyName = model.forumClassifyName;
//    forumDetailVC.forumClassifyId = model.forumClassifyID;
//    [self.navigationController pushViewController:forumDetailVC animated:YES];
}

@end
