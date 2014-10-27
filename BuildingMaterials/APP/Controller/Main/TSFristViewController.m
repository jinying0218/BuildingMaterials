//
//  TSFristViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSFristViewController.h"
#import "TSSecondsDealTableViewCell.h"
#import "TSShopReccommendTableViewCell.h"
#import "TSGoodsRecommendTableViewCell.h"
#import "TSGoodsExchangeTableViewCell.h"

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
    self.firstTable.rowHeight = 190;
    self.firstTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.firstTable.backgroundColor = [UIColor colorWithHexString:@"DEDEDE"];
    [self.rootView addSubview:_firstTable];
    
    UIView *banner = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 130)];
    self.firstTable.tableHeaderView = banner;

    UIScrollView *bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 120)];
//    banner.showsVerticalScrollIndicator = NO;
//    banner.showsHorizontalScrollIndicator = NO;
    bannerScrollView.contentSize = CGSizeMake( 3 * KscreenW, 120);
    bannerScrollView.delegate = self;
    bannerScrollView.pagingEnabled = YES;
    bannerScrollView.backgroundColor = [UIColor yellowColor];
    [banner addSubview:bannerScrollView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView1.frame = CGRectMake( 0, 0, KscreenW, 120);
    [bannerScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView2.frame = CGRectMake( KscreenW, 0, KscreenW, 120);
    [bannerScrollView addSubview:imageView2];

    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView3.frame = CGRectMake( KscreenW * 2, 0, KscreenW, 120);
    [bannerScrollView addSubview:imageView3];

}
#pragma mark - tableView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:{
//            TSSecondsDealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondsDealCell];
            cell = [tableView dequeueReusableCellWithIdentifier:secondsDealCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSSecondsDealTableViewCell" owner:nil options:nil]lastObject];
            }
            [(TSSecondsDealTableViewCell *)cell configureCell];
//            cell.textLabel.text = @"商品";
            
        }
            break;
        case 1:{
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = @"商品";

        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }
    
    return cell;
}
@end
