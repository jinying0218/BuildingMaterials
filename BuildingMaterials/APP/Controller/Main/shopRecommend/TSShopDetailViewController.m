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

static  NSString *const ShopDetailCollectionHeaderIdentifier = @"ShopDetailCollectionHeaderIdentifier";

@interface TSShopDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectViewDataArray;
@property (nonatomic, strong) TSShopDetailViewModel *viewModel;
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    self.tabBarController.tabBar.hidden =  YES;
    [self setupUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
//    self.tableDataArray = [[NSMutableArray alloc] initWithObjects:@"莫非瓷砖商家",@"莫非瓷砖商家",@"莫非瓷砖商家",@"莫非瓷砖",@"莫非瓷砖商家",@"莫非瓷砖商家", nil];
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

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT - KbottomBarHeight) collectionViewLayout:layout];
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
    return 5;
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
    shopSymbol.image = [UIImage imageNamedString:@"ss_09"];
    [shopSymbolback addSubview:shopSymbol];
    
    UILabel *shopName = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(shopSymbolback.frame) + 10, CGRectGetMaxY(bannerScrollView.frame) + 10, 100, 25)];
    shopName.text = @"大自然地板";
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

    UIButton *checkGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkGoodsBtn setBackgroundImage:[UIImage imageNamedString:@"shop_button_bg"] forState:UIControlStateNormal];
    [checkGoodsBtn setTitle:@"查看全部商品" forState:UIControlStateNormal];
    checkGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    checkGoodsBtn.frame = CGRectMake( KscreenW - 20 - 80, CGRectGetMaxY(bannerScrollView.frame) + 10, 80, 35);
    [checkGoodsBtn bk_addEventHandler:^(id sender) {
        NSLog(@"查看全部商品");
    } forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:checkGoodsBtn];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSShopDetailCollectionViewCell *cell = [TSShopDetailCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
