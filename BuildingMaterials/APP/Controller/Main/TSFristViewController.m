//
//  TSFristViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSFristViewController.h"
#import "TSSecondsListViewController.h"
#import "TSShopRecommedViewController.h"
#import "TSShopRecommandViewModel.h"

#import "TSSecondsDealTableViewCell.h"
#import "TSSecondsDealViewModel.h"
//#import "TSSecondDealDetailViewController.h"
//#import "TSSecondDealDetailViewModel.h"

#import "TSShopReccommendTableViewCell.h"
#import "TSShopDetailViewController.h"
#import "TSShopDetailViewModel.h"

#import "TSGoodsRecommendTableViewCell.h"
#import "TSGoodsRecommendViewController.h"
#import "TSGoodsRecommandViewModel.h"
#import "TSGoodsDetailViewController.h"
#import "TSGoodsDetailViewModel.h"


#import "TSGoodsExchangeViewController.h"
#import "TSGoodsExchangeViewModel.h"
#import "TSExchangeDetailViewModel.h"
#import "TSExchangeDetailViewController.h"
#import "TSGoodsExchangeTableViewCell.h"

#import <UIImageView+WebCache.h>
#import "TSSecKillModel.h"
#import "TSShopModel.h"
#import "TSGoodsRecommandModel.h"
#import "TSExchangeModel.h"
#import "TSAdModel.h"

#import "TSInviteDetailViewController.h"
#import "TSInviteDetailViewModel.h"

static NSString * const goodsRecommendCell = @"goodsRecommendCell";     //商品推荐
static NSString * const goodsExchangeCell = @"goodsExchangeCell";     //以物换物
static NSString * const shopRecommendCell = @"shopRecommendCell";     //商家推荐
static NSString * const secondsDealCell = @"secondsDealCell";     //掌上秒杀

@interface TSFristViewController ()<UITableViewDelegate,UITableViewDataSource,SecondsDealTableViewCellDelegate>
@property (nonatomic, strong) UITableView *firstTable;
@property (nonatomic, strong) UIScrollView *bannerScrollView;

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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
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
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSAdModel *adModel = [[TSAdModel alloc] init];
                [adModel setValueWithDict:dict];
                [self.viewModel.adArray addObject:adModel];
            }
            [self layoutSubViews];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    //秒杀
    [TSHttpTool getWithUrl:Frist_SecKillLoad_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"首页秒杀:%@",result);
        if ([result[@"success"] intValue] == 1) {
            NSArray *goods_result = result[@"goods_result"];
            for (NSDictionary *oneGoodsResult in goods_result) {
                TSSecKillModel *model = [[TSSecKillModel alloc] init];
                [model setValueForDictionary:oneGoodsResult];
                
                model.END_TIME = result[@"result"][@"END_TIME"];
                model.SecondsDeal_EventID = [[result[@"result"] objectForKey:@"ID"] intValue] ;
                model.STATUS = [[result[@"result"] objectForKey:@"STATUS"] intValue];
                [self.viewModel.secKillDataArray addObject:model];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"Frist_SecKillLoad_URL:%@",error);
    }];
    //首页商家加载
    [TSHttpTool getWithUrl:First_CompanyLoad_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"First_CompanyLoad_URL:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneShopModel in result[@"result"]) {
                TSShopModel *shopModel = [[TSShopModel alloc] init];
                [shopModel setValueForDictionary:oneShopModel];
                [self.viewModel.shopRecommendDataArray addObject:shopModel];
            }
            [self.firstTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商家推荐:%@",error);
    }];
    
    //首页商品推荐
    [TSHttpTool getWithUrl:First_GoodsLoad_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"商品推荐：%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneGoodsModel in result[@"result"]) {
                TSGoodsRecommandModel *goodsModel = [[TSGoodsRecommandModel alloc] init];
                [goodsModel setValueForDictionary:oneGoodsModel];
                [self.viewModel.goodsRecommendDataArray addObject:goodsModel];
            }
            [self.firstTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商品推荐:%@",error);
    }];
    
    //首页换物
    [TSHttpTool getWithUrl:First_Exchange_URL params:nil withCache:NO success:^(id result) {
//        NSLog(@"First_Exchange_URL:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneExchangeModel in result[@"result"]) {
                TSExchangeModel *exchangeModel = [[TSExchangeModel alloc] init];
                [exchangeModel setValueWithDict:oneExchangeModel];
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
    [self createNavigationBarTitle:@"大安顺" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.firstTable = [[UITableView alloc] initWithFrame:CGRectMake( 0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - KbottomBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.firstTable.delegate = self;
    self.firstTable.dataSource = self;
    self.firstTable.showsVerticalScrollIndicator = NO;
    self.firstTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.firstTable.backgroundColor = [UIColor colorWithHexString:@"DEDEDE"];
    [self.rootView addSubview:_firstTable];
    
    UIView *banner = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 130)];
    banner.userInteractionEnabled = YES;
    self.firstTable.tableHeaderView = banner;

    self.bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 120)];
//    banner.showsVerticalScrollIndicator = NO;
//    banner.showsHorizontalScrollIndicator = NO;
    self.bannerScrollView.delegate = self;
    self.bannerScrollView.pagingEnabled = YES;
    self.bannerScrollView.backgroundColor = [UIColor darkGrayColor];
    [banner addSubview:self.bannerScrollView];
    
}

- (void)layoutSubViews{
    int i = 0;
    for (TSAdModel *oneAdModel in self.viewModel.adArray) {
        UIImageView *imageView1 = [[UIImageView alloc] init];
        imageView1.userInteractionEnabled = YES;
        imageView1.frame = CGRectMake( KscreenW * i, 0, KscreenW, 120);
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:oneAdModel.ad_url]placeholderImage:[UIImage imageNamed:@"not_load_ad"]];
        [self.bannerScrollView addSubview:imageView1];
        i ++;
        
        [imageView1 bk_whenTapped:^{
            
            if ([oneAdModel.ad_type isEqualToString:@"TYPE_COMPANY"]) {
                TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
                viewModel.companyID = oneAdModel.ad_go_ID;
                TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
                [self.navigationController pushViewController:shopDetailVC animated:YES];

            }else if ([oneAdModel.ad_type isEqualToString:@"TYPE_GOODS"]){
                TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
                viewModel.isSecondsDeal = NO;
                viewModel.goodsID = oneAdModel.ad_go_ID;
                TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
                goodsDetailVC.viewModel = viewModel;
                [self.navigationController pushViewController:goodsDetailVC animated:YES];

            }else if ([oneAdModel.ad_type isEqualToString:@"TYPE_POST"]){
                
                TSInviteDetailViewModel *viewModel = [[TSInviteDetailViewModel alloc] init];
                viewModel.postID = oneAdModel.ad_go_ID;
                TSInviteDetailViewController *inviteDetailVC = [[TSInviteDetailViewController alloc] init];
                inviteDetailVC.viewModel = viewModel;
                [self.navigationController pushViewController:inviteDetailVC animated:YES];

            }
        }];
        
        
    }
    if (self.viewModel.adArray.count == 0) {
        UIImageView *imageView1 = [[UIImageView alloc] init];
        imageView1.frame = CGRectMake( KscreenW * i, 0, KscreenW, 120);
        [imageView1 setImage:[UIImage imageNamed:@"not_load_ad"]];
        [self.bannerScrollView addSubview:imageView1];
    }
    self.bannerScrollView.contentSize = CGSizeMake( self.viewModel.adArray.count * KscreenW, 120);
}

#pragma  mark - secondDealTableView delegate           点击首页秒杀商品
- (void)touchCellImageView:(UIButton *)button{
    int index = (int)button.tag - 10000;
    TSSecKillModel *model = self.viewModel.secKillDataArray[index];
//秒杀
    if (model.SECKILL_NUMBER - model.SECKILL_NUMBER_NOW <= 0) {
        [self showProgressHUD:@"已抢光了" delay:1];
        return;
    }

    TSSecondsDealTableViewCell *cell = (TSSecondsDealTableViewCell *)[self.firstTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if (cell.isOver) {
        [self showProgressHUD:@"秒杀已结束" delay:1];
        return;
    }
    TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
    viewModel.goodsID = model.goodsId;
    viewModel.isSecondsDeal = YES;
    viewModel.seckillModel = model;
    TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
    goodsDetailVC.viewModel = viewModel;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];

}
#pragma mark - tableView delegate & dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = @[@"185",@"185",@"230",@"216"];
    return [array[indexPath.row] intValue];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @weakify(self);

    if (indexPath.row == 0) {
        TSSecondsDealTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:secondsDealCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSSecondsDealTableViewCell" owner:nil options:nil]lastObject];
            cell.delegate = self;
        }
        [cell configureCellWithModelArray:self.viewModel.secKillDataArray];
        return cell;

    }else if (indexPath.row == 1) {
        //商家推荐
        TSShopReccommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:shopRecommendCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSShopReccommendTableViewCell" owner:nil options:nil]lastObject];
            [cell.fristShopImage bk_whenTapped:^{
                @strongify(self);
                int index = (int)cell.fristShopImage.tag - 20000;
                TSShopModel *shopModel = self.viewModel.shopRecommendDataArray[index];
                TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
                viewModel.companyID = shopModel.I_D;
                TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
                [self.navigationController pushViewController:shopDetailVC animated:YES];

            }];
            [cell.secondShopImage bk_whenTapped:^{
                @strongify(self);
                int index = (int)cell.secondShopImage.tag - 20000;
                TSShopModel *shopModel = self.viewModel.shopRecommendDataArray[index];
                TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
                viewModel.companyID = shopModel.I_D;
                TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
                [self.navigationController pushViewController:shopDetailVC animated:YES];
                
            }];
            [cell.thirdShopImage bk_whenTapped:^{
                @strongify(self);
                int index = (int)cell.thirdShopImage.tag - 20000;
                TSShopModel *shopModel = self.viewModel.shopRecommendDataArray[index];
                TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
                viewModel.companyID = shopModel.I_D;
                TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
                [self.navigationController pushViewController:shopDetailVC animated:YES];
                
            }];

        }
        [cell configureCellWithModelArray:self.viewModel.shopRecommendDataArray];
        return cell;

    }else if (indexPath.row == 2) {
        //商品推荐
        TSGoodsRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsRecommendCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSGoodsRecommendTableViewCell" owner:nil options:nil]lastObject];
            [cell.firstGoodsImage bk_whenTapped:^{
                @strongify(self);
                if (self.viewModel.goodsRecommendDataArray.count != 0) {
                    TSGoodsRecommandModel *goodsModel = self.viewModel.goodsRecommendDataArray[cell.firstGoodsImage.tag - 21000];
                    TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
                    viewModel.isSecondsDeal = NO;
                    viewModel.goodsID = goodsModel.I_D;
                    TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
                    goodsDetailVC.viewModel = viewModel;
                    [self.navigationController pushViewController:goodsDetailVC animated:YES];
                }
            }];
            [cell.secondGoodsImage bk_whenTapped:^{
                @strongify(self);
                TSGoodsRecommandModel *goodsModel = self.viewModel.goodsRecommendDataArray[cell.secondGoodsImage.tag - 21000];
                TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
                viewModel.goodsID = goodsModel.I_D;
                viewModel.isSecondsDeal = NO;
                TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
                goodsDetailVC.viewModel = viewModel;
                [self.navigationController pushViewController:goodsDetailVC animated:YES];
                
            }];

        }

        [cell configureCellWithModelArray:self.viewModel.goodsRecommendDataArray];

        return cell;

    }else {
        //以物换物
        TSGoodsExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsExchangeCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSGoodsExchangeTableViewCell" owner:nil options:nil]lastObject];
            [cell.firstExchangeGoodsImage bk_whenTapped:^{
                @strongify(self);
                TSExchangeListModel *model = self.viewModel.goodsExchangeDataArray[cell.firstExchangeGoodsImage.tag - 22000];
                TSExchangeDetailViewModel *viewModel = [[TSExchangeDetailViewModel alloc] init];
                viewModel.exchangeGoodsModel = model;
                TSExchangeDetailViewController *exchangeDetailVC = [[TSExchangeDetailViewController alloc] init];
                exchangeDetailVC.viewModel = viewModel;
                [self.navigationController pushViewController:exchangeDetailVC animated:YES];
            }];
            [cell.secondExchangeGoodsImage bk_whenTapped:^{
                @strongify(self);
                TSExchangeListModel *model = self.viewModel.goodsExchangeDataArray[cell.secondExchangeGoodsImage.tag - 22000];
                TSExchangeDetailViewModel *viewModel = [[TSExchangeDetailViewModel alloc] init];
                viewModel.exchangeGoodsModel = model;
                TSExchangeDetailViewController *exchangeDetailVC = [[TSExchangeDetailViewController alloc] init];
                exchangeDetailVC.viewModel = viewModel;
                [self.navigationController pushViewController:exchangeDetailVC animated:YES];
                
            }];

        }
        [cell configureCellWithModelArray:self.viewModel.goodsExchangeDataArray];
        return cell;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            TSSecondsDealViewModel *viewModel = [[TSSecondsDealViewModel alloc] init];
            TSSecondsListViewController *secondsDealVC = [[TSSecondsListViewController alloc] initWithViewModel:viewModel];
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
            viewModel.page = 1;
            viewModel.classifyID = 0;
            viewModel.goodsOrderType = @"1";
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
