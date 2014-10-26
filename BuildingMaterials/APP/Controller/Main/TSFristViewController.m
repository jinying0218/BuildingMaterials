//
//  TSFristViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSFristViewController.h"

static NSString * const goodsRecommendCell = @"goodsRecommendCell";     //商品推荐
static NSString * const shopRecommendCell = @"shopRecommendCell";     //商家推荐
static NSString * const secondsDealCell = @"secondsDealCell";     //掌上秒杀

@interface TSFristViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *firstTable;
@end

@implementation TSFristViewController

#pragma mark - controller method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"贵州建材网" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.firstTable = [[UITableView alloc] initWithFrame:CGRectMake( 0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - KbottomBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.firstTable.delegate = self;
    self.firstTable.dataSource = self;
    self.firstTable.showsVerticalScrollIndicator = NO;
    self.firstTable.rowHeight = 44;
    [self.rootView addSubview:_firstTable];
    
    UIScrollView *banner = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 100)];
//    banner.showsVerticalScrollIndicator = NO;
//    banner.showsHorizontalScrollIndicator = NO;
    banner.contentSize = CGSizeMake( 3 * KscreenW, 100);
    banner.delegate = self;
    banner.pagingEnabled = YES;
    banner.backgroundColor = [UIColor yellowColor];
    self.firstTable.tableHeaderView = banner;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView1.frame = CGRectMake( 0, 0, KscreenW, 100);
    [banner addSubview:imageView1];
    
}
#pragma mark - tableView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"商品";
    return cell;
}
@end
