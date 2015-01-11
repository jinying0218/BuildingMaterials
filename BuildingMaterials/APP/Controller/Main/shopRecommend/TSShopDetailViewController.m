//
//  TSShopDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/12/17.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopDetailViewController.h"
#import "TSShopDetailViewModel.h"
#import "TSShopDetailCollectionViewCell.h"
#import "TSGoodsRecommandModel.h"
#import <UIImageView+WebCache.h>

#import "TSShopGoodsViewModel.h"
#import "TSShopGoodsViewController.h"

#import "TSGoodsDetailViewController.h"
#import "TSGoodsDetailViewModel.h"

static  NSString *const ShopDetailCollectionHeaderIdentifier = @"ShopDetailCollectionHeaderIdentifier";

@interface TSShopDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectViewDataArray;
@property (nonatomic, strong) TSShopDetailViewModel *viewModel;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) UIButton *checkGoodsBtn;

@end

@implementation TSShopDetailViewController
- (instancetype)initWithViewModel:(TSShopDetailViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initializeData];
    [self setupUI];
    self.tabBarController.tabBar.hidden = YES;
    [self blindActionHandler];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark - blind methods
- (void)blindActionHandler{

}

- (void)initializeData{
//    self.tableDataArray = [[NSMutableArray alloc] initWithObjects:@"莫非瓷砖商家",@"莫非瓷砖商家",@"莫非瓷砖商家",@"莫非瓷砖",@"莫非瓷砖商家",@"莫非瓷砖商家", nil];
    
    NSDictionary *params = @{@"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
    [TSHttpTool getWithUrl:CompanyDetail_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"商家详情：%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.shopModel setShopModelValueForDictionary:result[@"result"]];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商家详情：%@",error);
    }];
    
    NSDictionary *shopGoodsParams = @{@"page" : [NSString stringWithFormat:@"%d",self.page],
                                      @"goodsOrderType" : @"1",
                                      @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
    [TSHttpTool getWithUrl:CompanyGoodsLoad_URL params:shopGoodsParams withCache:NO success:^(id result) {
//        NSLog(@"商家物品：%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneDict in result[@"result"]) {
                TSGoodsRecommandModel *goodsModel = [[TSGoodsRecommandModel alloc] init];
                [goodsModel setValueForDictionary:oneDict];
                [self.viewModel.dataArray addObject:goodsModel];
            }
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商家物品：%@",error);

    }];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"商家详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    layout.itemSize = CGSizeMake( 150, 170);
    // 3.设置每一行之间的间距
    layout.minimumLineSpacing = 5;
    // 4.设置间距
    layout.sectionInset = UIEdgeInsetsMake( 5, 5, 0, 5);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT) collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.rootView addSubview:self.collectionView];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ShopDetailCollectionHeaderIdentifier];

    /*
    CellConfigureBlock configureBlock = ^(TSShopRecommedDetailTableViewCell *cell,id taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSShopRecommedDetailTableViewCell" items:self.tableDataArray cellIdentifier:ShopRecommedDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    */
}

#pragma mark - UICollectionView方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake( KscreenW, 180);
}

//段头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ShopDetailCollectionHeaderIdentifier forIndexPath:indexPath];
    for (UIView *subView in headerView.subviews) {
        [subView removeFromSuperview];
    }
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 120)];
    //    banner.showsVerticalScrollIndicator = NO;
    //    banner.showsHorizontalScrollIndicator = NO;
    bannerScrollView.contentSize = CGSizeMake( 3 * KscreenW, 120);
    bannerScrollView.delegate = self;
    bannerScrollView.pagingEnabled = YES;
    bannerScrollView.backgroundColor = [UIColor yellowColor];
    [headerView addSubview:bannerScrollView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView1.frame = CGRectMake( 0, 0, KscreenW, 120);
    [bannerScrollView addSubview:imageView1];
    
    UIImageView *shopSymbolback = [[UIImageView alloc] initWithFrame:CGRectMake( 20, headerView.frame.size.height - 74, 70, 70)];
    shopSymbolback.image = [UIImage imageNamedString:@"ss_06"];
    [headerView addSubview:shopSymbolback];

    UIImageView *shopSymbol = [[UIImageView alloc] initWithFrame:CGRectMake( 5, 5, 60, 60)];
    [shopSymbol sd_setImageWithURL:[NSURL URLWithString:self.viewModel.shopModel.COMPANY_IMAGE_URL]];
    [shopSymbolback addSubview:shopSymbol];
    
    UILabel *shopName = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(shopSymbolback.frame) + 10, CGRectGetMaxY(bannerScrollView.frame) + 10, 100, 25)];
    shopName.text = self.viewModel.shopModel.COMPANY_NAME;
    shopName.adjustsFontSizeToFitWidth = YES;
    shopName.textColor = [UIColor colorWithHexString:@"226e8a"];
    shopName.font = [UIFont systemFontOfSize:17];
//    shopName.backgroundColor = [UIColor redColor];
    [headerView addSubview:shopName];
    
    UILabel *goodsKinds = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(shopSymbolback.frame) + 10, CGRectGetMaxY(shopName.frame), 100, 20)];
    goodsKinds.text = @"355种商品";
//    goodsKinds.textColor = [UIColor colorWithHexString:@"226e8a"];
    goodsKinds.font = [UIFont systemFontOfSize:14];
//    goodsKinds.backgroundColor = [UIColor blueColor];
    [headerView addSubview:goodsKinds];

    self.checkGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkGoodsBtn setBackgroundImage:[UIImage imageNamedString:@"shop_button_bg"] forState:UIControlStateNormal];
    [self.checkGoodsBtn setTitle:@"查看全部商品" forState:UIControlStateNormal];
    self.checkGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.checkGoodsBtn.frame = CGRectMake( KscreenW - 20 - 80, CGRectGetMaxY(bannerScrollView.frame) + 10, 80, 35);
    @weakify(self);
    [self.checkGoodsBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSShopGoodsViewModel *viewModel = [[TSShopGoodsViewModel alloc] init];
        viewModel.companyID = self.viewModel.companyID;
        viewModel.companyName = self.viewModel.shopModel.COMPANY_NAME;
        TSShopGoodsViewController *shopGoodsVC = [[TSShopGoodsViewController alloc] init];
        shopGoodsVC.viewModel = viewModel;
        [self.navigationController pushViewController:shopGoodsVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];

    [headerView addSubview:self.checkGoodsBtn];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSShopDetailCollectionViewCell *cell = [TSShopDetailCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    TSGoodsRecommandModel *goodsModel = self.viewModel.dataArray[indexPath.row];
    [cell configureCellWithModel:goodsModel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSGoodsRecommandModel *goodsModel = self.viewModel.dataArray[indexPath.row];
    TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
    viewModel.goodsID = goodsModel.I_D;
    TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
    goodsDetailVC.viewModel = viewModel;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];

}
@end
