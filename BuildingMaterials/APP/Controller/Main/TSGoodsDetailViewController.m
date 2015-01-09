//
//  TSGoodsDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsDetailViewController.h"
#import "TSGoodsInfoModel.h"
#import "TSShopModel.h"
#import "TSGoodsParamsModel.h"

@interface TSGoodsDetailViewController ()

@end

@implementation TSGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];
    self.tabBarController.tabBar.hidden =  YES;
    
    [self bindActionHandler];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
    
    NSDictionary *params = @{@"id" : [NSString stringWithFormat:@"%d",self.viewModel.goodsID]};
    [TSHttpTool getWithUrl:GoodsInfo_URL params:params withCache:NO success:^(id result) {
        NSLog(@"商品信息:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.shopModel setShopModelValueForDictionary:result[@"companyResult"]];
            [self.viewModel.goodsInfoModel setValueForDictionary:result[@"goodsResult"]];
        }

    } failure:^(NSError *error) {
        NSLog(@"商品信息:%@",error);

    }];
    //商品规格参数
    [TSHttpTool getWithUrl:GoodsParameters_URL params:params withCache:NO success:^(id result) {
        NSLog(@"商品参数:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSGoodsParamsModel *goodsParamsModel = [[TSGoodsParamsModel alloc] init];
                [goodsParamsModel setValueWithDictionary:dict];
                [self.viewModel.dataArray addObject:goodsParamsModel];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"商品参数:%@",error);

    }];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"商品详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
}
- (void)bindActionHandler{
    
}
@end
