//
//  TSCommentViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/16.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCommentViewController.h"
#import "TSCommentViewModel.h"
#import "TSCommentTableViewCell.h"
#import "MJRefresh.h"
#import "TSCommentModel.h"

static NSString *const CommentTableViewCellIdentifier = @"CommentTableViewCell";

@interface TSCommentViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSCommentViewModel *viewModel;
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSCommentViewController
- (instancetype)initWithViewModel:(TSCommentViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializeData{
    NSDictionary *params = @{@"page" : [NSString stringWithFormat:@"%d",self.viewModel.page],
                             @"id" : [NSString stringWithFormat:@"%d",self.viewModel.goodsInfoModel.goodsID]};
    [TSHttpTool getWithUrl:GoodsComment_URL params:params withCache:NO success:^(id result) {
        NSLog(@"商品评价：%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSCommentModel *commentModel = [[TSCommentModel alloc] init];
                [commentModel setValueWithDict:dict];
                [self.viewModel.allComments addObject:commentModel];
            }
            [self.tableView reloadData];

        }
    } failure:^(NSError *error) {
        NSLog(@"商品评价：%@",error);
    }];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"商品评论" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    CellConfigureBlock configureBlock = ^(TSCommentTableViewCell *cell,TSCommentModel *taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };


    self.tableView.frame = CGRectMake( 0, CGRectGetMaxY(self.navigationBar.frame), KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT);
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSCommentTableViewCell" items:self.viewModel.allComments cellIdentifier:CommentTableViewCellIdentifier configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self.rootView addSubview:self.tableView];


}


@end
