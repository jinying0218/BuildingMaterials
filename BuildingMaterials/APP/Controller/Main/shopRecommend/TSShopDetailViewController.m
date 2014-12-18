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
#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
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
