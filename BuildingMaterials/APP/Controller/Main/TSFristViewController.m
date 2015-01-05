//
//  TSFristViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSFristViewController.h"
#import "TSSecondsDealViewController.h"
#import "TSShopRecommedViewController.h"
#import "TSShopRecommandViewModel.h"

#import "TSGoodsRecommendViewController.h"
#import "TSGoodsRecommandViewModel.h"

#import "TSGoodsExchangeViewController.h"
#import "TSGoodsExchangeViewModel.h"


#import "TSSecondsDealTableViewCell.h"
#import "TSSecondsDealViewModel.h"
#import "TSShopReccommendTableViewCell.h"
#import "TSGoodsRecommendTableViewCell.h"
#import "TSGoodsExchangeTableViewCell.h"

#import <UIImageView+WebCache.h>
#import "TSSecKillModel.h"
#import "TSShopModel.h"
#import "TSGoodsRecommandModel.h"
#import "TSExchangeModel.h"


static NSString * const goodsRecommendCell = @"goodsRecommendCell";     //商品推荐
static NSString * const goodsExchangeCell = @"goodsExchangeCell";     //以物换物
static NSString * const shopRecommendCell = @"shopRecommendCell";     //商家推荐
static NSString * const secondsDealCell = @"secondsDealCell";     //掌上秒杀

@interface TSFristViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *firstTable;

@end

@implementation TSFristViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark - controller method
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - load date
- (void)loadData{
    //广告位
    [TSHttpTool getWithUrl:Frist_ADLoad_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"Frist_ADLoad_URL:%@",result);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    //秒杀
    [TSHttpTool getWithUrl:Frist_SecKillLoad_URL params:nil withCache:nil success:^(id result) {
        NSLog(@"Frist_SecKillLoad_URL:%@",result);
        NSArray *goods_result = result[@"goods_result"];
        for (NSDictionary *oneGoodsResult in goods_result) {
            TSSecKillModel *model = [[TSSecKillModel alloc] init];
            [model setValuesForKeysWithDictionary:oneGoodsResult];
            model.END_TIME = result[@"result"][@"END_TIME"];
            model.STATUS = [result[@"STATUS"] intValue];
            [self.viewModel.secKillDataArray addObject:model];
        }
        [self.firstTable reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Frist_SecKillLoad_URL:%@",error);
    }];
    //首页商家加载
    [TSHttpTool getWithUrl:First_CompanyLoad_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"First_CompanyLoad_URL:%@",result);
        if ([result objectForKey:@"success"]) {
            for (NSDictionary *oneShopModel in result[@"result"]) {
                TSShopModel *shopModel = [[TSShopModel alloc] init];
                [shopModel setValuesForKeysWithDictionary:oneShopModel];
                [self.viewModel.shopRecommendDataArray addObject:shopModel];
            }
            [self.firstTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商家推荐:%@",error);
    }];
    
    //首页商品推荐
    [TSHttpTool getWithUrl:First_GoodsLoad_URL params:nil withCache:NO success:^(id result) {
        NSLog(@"商品推荐：%@",result);
        if ([result objectForKey:@"success"]) {
            for (NSDictionary *oneGoodsModel in result[@"result"]) {
                TSGoodsRecommandModel *goodsModel = [[TSGoodsRecommandModel alloc] init];
                goodsModel.GOODS_CLASSIFY_ID = [oneGoodsModel[@"GOODS_CLASSIFY_ID"] intValue];
                goodsModel.GOODS_COMPANY_ID = [oneGoodsModel[@"GOODS_COMPANY_ID"] intValue];
                goodsModel.GOODS_DES = oneGoodsModel[@"GOODS_DES"];
                goodsModel.GOODS_DES_SIMPLE = oneGoodsModel[@"GOODS_DES_SIMPLE"];
                goodsModel.GOODS_HEAD_IMAGE = oneGoodsModel[@"GOODS_HEAD_IMAGE"];
                goodsModel.GOODS_NAME = oneGoodsModel[@"GOODS_NAME"];
                goodsModel.GOODS_NEW_PRICE = [oneGoodsModel[@"GOODS_NEW_PRICE"] intValue];
//                goodsModel.GOODS_OLD_PRICE = oneGoodsModel[@"GOODS_OLD_PRICE"] ? [oneGoodsModel[@"GOODS_OLD_PRICE"] intValue] : @"";
                goodsModel.GOODS_SELL_NUMBER = [oneGoodsModel[@"GOODS_SELL_NUMBER"] intValue];
                goodsModel.GOODS_WEIGHT = [oneGoodsModel[@"GOODS_WEIGHT"] intValue];
                goodsModel.I_D = [oneGoodsModel[@"ID"] intValue];
                goodsModel.IS_RECOMMEND = [oneGoodsModel[@"IS_RECOMMEND"] intValue];
                goodsModel.IS_USED = [oneGoodsModel[@"IS_USED"] intValue];
                goodsModel.N_O = [oneGoodsModel[@"NO"] intValue];
                goodsModel.RECOMMEND_TIME = oneGoodsModel[@"RECOMMEND_TIME"];

                [self.viewModel.goodsRecommendDataArray addObject:goodsModel];
            }
            [self.firstTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商品推荐:%@",error);
    }];
    
    //首页换物
    [TSHttpTool getWithUrl:First_Exchange_URL params:nil withCache:NO success:^(id result) {
        NSLog(@"First_Exchange_URL:%@",result);
        if ([result objectForKey:@"success"]) {
            for (NSDictionary *oneExchangeModel in result[@"result"]) {
                TSExchangeModel *exchangeModel = [[TSExchangeModel alloc] init];
                [exchangeModel setValuesForKeysWithDictionary:oneExchangeModel];
                [self.viewModel.goodsExchangeDataArray addObject:exchangeModel];
            }
            [self.firstTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"以物换物：%@",error);
    }];
    
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
    bannerScrollView.backgroundColor = [UIColor darkGrayColor];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = @[@"185",@"185",@"230",@"245"];
    return [array[indexPath.row] intValue];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:{
            //掌上秒杀
//            TSSecondsDealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondsDealCell];
            cell = [tableView dequeueReusableCellWithIdentifier:secondsDealCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSSecondsDealTableViewCell" owner:nil options:nil]lastObject];
            }
            [(TSSecondsDealTableViewCell *)cell configureCellWithModelArray:self.viewModel.secKillDataArray];
//            cell.textLabel.text = @"商品";
            
        }
            break;
        case 1:{
            //商家推荐
            cell = [tableView dequeueReusableCellWithIdentifier:shopRecommendCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSShopReccommendTableViewCell" owner:nil options:nil]lastObject];
            }
            [(TSShopReccommendTableViewCell *)cell configureCellWithModelArray:self.viewModel.shopRecommendDataArray];
        }
            break;
        case 2:{
            //商品推荐
            cell = [tableView dequeueReusableCellWithIdentifier:goodsRecommendCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSGoodsRecommendTableViewCell" owner:nil options:nil]lastObject];
            }
            
            [(TSGoodsRecommendTableViewCell *)cell configureCellWithModelArray:self.viewModel.goodsRecommendDataArray];

        }
            break;
        case 3:{
            //以物换物
            cell = [tableView dequeueReusableCellWithIdentifier:goodsExchangeCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSGoodsExchangeTableViewCell" owner:nil options:nil]lastObject];
            }
            [(TSGoodsExchangeTableViewCell *)cell configureCellWithModelArray:self.viewModel.goodsExchangeDataArray];
//            [(TSSecondsDealTableViewCell *)cell configureCell];

        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            TSSecondsDealViewModel *viewModel = [[TSSecondsDealViewModel alloc] init];
            
            TSSecondsDealViewController *secondsDealVC = [[TSSecondsDealViewController alloc] initWithViewModel:viewModel];
            [self.navigationController pushViewController:secondsDealVC animated:YES];
        }
            break;
        case 1:{
            TSShopRecommandViewModel *viewModel = [[TSShopRecommandViewModel alloc] init];
            TSShopRecommedViewController *shopRecommedVC = [[TSShopRecommedViewController alloc] init];
            shopRecommedVC.viewModel = viewModel;
            [self.navigationController pushViewController:shopRecommedVC animated:YES];
        }
            break;
        case 2:{
            TSGoodsRecommandViewModel *viewModel = [[TSGoodsRecommandViewModel alloc] init];
            
            TSGoodsRecommendViewController *goodsRecommedVC = [[TSGoodsRecommendViewController alloc] init];
            goodsRecommedVC.viewModel = viewModel;
            [self.navigationController pushViewController:goodsRecommedVC animated:YES];
        }
            break;
        case 3:{
            TSGoodsExchangeViewModel *viewModel = [[TSGoodsExchangeViewModel alloc] init];
            TSGoodsExchangeViewController *goodsExchangeVC = [[TSGoodsExchangeViewController alloc] init];
            goodsExchangeVC.viewModel = viewModel;
            [self.navigationController pushViewController:goodsExchangeVC animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
