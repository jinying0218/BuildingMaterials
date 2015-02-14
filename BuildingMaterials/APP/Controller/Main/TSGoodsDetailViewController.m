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
#import "LPLabel.h"
#import "TSParamsButton.h"

#import <UIImageView+WebCache.h>
//#import "NSArray+BSJSONAdditions.h"
//#import "NSDictionary+BSJSONAdditions.h"
#import "JSONKit.h"

#import "TSCommentViewController.h"
#import "TSCommentViewModel.h"

#import "TSGoodsDesViewController.h"
#import "TSOrderConfirmViewController.h"
#import "TSOrderConfirmViewModel.h"

#import "TSShopDetailViewController.h"
#import "TSShopDetailViewModel.h"
#import "TSUserModel.h"
#import "TSSecKillModel.h"
#import "TSGoodsImageModel.h"

#import "TSShopCarViewModel.h"
#import "TSShopCarViewController.h"

#define Tag_paramsButton 8000

@interface TSGoodsDetailViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *banner;//商品图片展示
@property (nonatomic, strong) IBOutlet UIScrollView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;

@property (weak, nonatomic) IBOutlet UIButton *enterShop;//进入店铺
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
@property (weak, nonatomic) IBOutlet UILabel *goodsNewPrice;
@property (weak, nonatomic) IBOutlet LPLabel *goodsOldPrice;

@property (weak, nonatomic) IBOutlet UILabel *goodsSellNumber;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;   //收藏

@property (weak, nonatomic) IBOutlet UIButton *addShopCarButton;//加入购物车
@property (weak, nonatomic) IBOutlet UIButton *buyButton;//立即购买
@property (weak, nonatomic) IBOutlet UIView *goodsInfoView;

@property (weak, nonatomic) IBOutlet UIView *goodsComment;  //商品评价
@property (weak, nonatomic) IBOutlet UILabel *goodsCommentCount;
@property (weak, nonatomic) IBOutlet UIView *goodsDetailView;   //商品详情view
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIView *goodsParamsView;

@property (weak, nonatomic) IBOutlet UIView *goodsCountView;        //数量参数View
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIView *shopView;  //底部view

@property (strong, nonatomic) UIButton *minerBtn;
@property (strong, nonatomic) UILabel *count;
@property (strong, nonatomic) UIButton *plusBtn;

@property (strong, nonatomic) UIImageView *countImageView;
@property (nonatomic, strong) TSUserModel *userModel;
@end

@implementation TSGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userModel = [TSUserModel getCurrentLoginUser];
    [self initializeData];
    [self setupUI];
    self.tabBarController.tabBar.hidden =  YES;
    
    [self blindViewModel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
    
    [self showProgressHUD];
    NSDictionary *params = @{@"id" : [NSString stringWithFormat:@"%d",self.viewModel.goodsID]};
    [TSHttpTool getWithUrl:GoodsInfo_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"商品信息:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.shopModel setShopModelValueForDictionary:result[@"companyResult"]];
            [self.viewModel.goodsInfoModel setValueForDictionary:result[@"goodsResult"]];
            
            self.viewModel.loadGoodsInfo = YES;
            [self initialAllData];
        }

    } failure:^(NSError *error) {
        NSLog(@"商品信息:%@",error);

    }];
    //商品规格参数
    [TSHttpTool getWithUrl:GoodsParameters_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"商品参数:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSGoodsParamsModel *goodsParamsModel = [[TSGoodsParamsModel alloc] init];
                [goodsParamsModel setValueWithDictionary:dict];
                [self.viewModel.dataArray addObject:goodsParamsModel];
            }
            self.viewModel.loadGoodsParams = YES;
            [self initialAllData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"商品参数:%@",error);
    }];
    
    NSDictionary *loadImageParams = @{@"id" : [NSString stringWithFormat:@"%d",self.viewModel.goodsID]};
    
    [TSHttpTool getWithUrl:GoodsImageLoad_URL params:loadImageParams withCache:NO success:^(id result) {
//        NSLog(@"商品详情图片：%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.imageArray removeAllObjects];
            for (NSDictionary *dict in result[@"result"]) {
                TSGoodsImageModel *imageModel = [[TSGoodsImageModel alloc] init];
                [imageModel modelWithDict:dict];
                [self.viewModel.imageArray addObject:imageModel];
            }
            [self loadBannerImageView];
        }
    } failure:^(NSError *error) {
        NSLog(@"换物图片:%@",error);
    }];
}
#pragma mark - set up UI
- (void)setupUI{
    
    if (self.viewModel.isSecondsDeal) {
        [self createNavigationBarTitle:@"秒杀详情" leftButtonImageName:@"Previous" rightButtonImageName:@"navi_shopCar_btn"];
        self.goodsOldPrice.hidden = NO;
        self.goodsOldPrice.strikeThroughEnabled = YES;
    } else {
        [self createNavigationBarTitle:@"商品详情" leftButtonImageName:@"Previous" rightButtonImageName:@"navi_shopCar_btn"];
    }
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    [self.navigationBar addSubview:self.naviRightBtn];
    
    _enterShop.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _enterShop.layer.borderWidth = 1;
    
    self.baseView.contentSize = CGSizeMake(KscreenW, CGRectGetMaxY(self.shopView.frame) + 54 + 120);
    
    if (self.viewModel.isSecondsDeal) {
        self.addShopCarButton.hidden = YES;
        self.buyButton.frame = CGRectMake( KscreenW - 70 - 60, 80, 60, 35);
    }
}
- (void)loadBannerImageView{
    self.banner.contentSize = CGSizeMake( KscreenW * self.viewModel.imageArray.count, 129);
    int i = 0;
    for (TSGoodsImageModel *imageModel in self.viewModel.imageArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( KscreenW * i, 0, KscreenW, 129)];
        if (![imageModel.imageUrl isEqual:[NSNull null]]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.imageUrl] placeholderImage:[UIImage imageNamed:@"not_load_ad"]];
        }
        [self.banner addSubview:imageView];
        i ++;
    }

}
- (void)initialAllData{
    if (self.viewModel.loadGoodsInfo && self.viewModel.loadGoodsParams) {
        [self hideProgressHUD];
        [self layoutSubviews];
    }
}

- (void)setuiParamsView {
    
    UILabel *lastLine = nil;
    int buttonTag = 0;
    for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
        TSGoodsParamsModel *oneParameterModel = self.viewModel.dataArray[i];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@:",oneParameterModel.goodsParametersName];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        
        CGSize fitLabelSize = [UILabel sizeWithLabel:label];
        label.frame = CGRectMake( 10, 10 + 50 * i, fitLabelSize.width, fitLabelSize.height);
        [self.goodsParamsView addSubview:label];
        
        for (int j = 0; j < oneParameterModel.parametersList.count; j ++ ) {
            TSParametersList *oneParam = oneParameterModel.parametersList[j];
            
            //            CGRect titleSize = [oneParam.parametersName boundingRectWithSize:CGSizeMake( CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
            TSParamsButton *button = [TSParamsButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:oneParam.parametersName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"c9cbcb"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.frame = CGRectMake( CGRectGetMaxX(label.frame) + 30 + j * 90, 5 + 50 * i, 60, 30);
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 5;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.backgroundColor = [UIColor clearColor];
            button.tag = Tag_paramsButton + buttonTag;
            button.indexPath = [NSIndexPath indexPathForItem:buttonTag inSection:i];
            [self.goodsParamsView addSubview:button];
            buttonTag ++;
            [button addTarget:self action:@selector(paramsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UILabel *seperatorLine = [[UILabel alloc] initWithFrame:CGRectMake( 10, CGRectGetMaxY(label.frame) + 15, KscreenW - 20, 1)];
        seperatorLine.backgroundColor = [UIColor colorWithHexString:@"c9cbcb"];
        [self.goodsParamsView addSubview:seperatorLine];
        lastLine = seperatorLine;
    }
    [lastLine removeFromSuperview];
}

- (void)layoutSubviews{
    
    if (!self.viewModel.goodsInfoModel.isRecommend) {
        self.recommendLabel.hidden = YES;
    }
    self.goodsCommentCount.text = @"";
    self.goodsName.text = self.viewModel.goodsInfoModel.goodsName;
    self.goodsName.adjustsFontSizeToFitWidth = YES;
    self.goodsDes.text = self.viewModel.goodsInfoModel.goodsDesSimple;
    self.goodsNewPrice.text = [NSString stringWithFormat:@"￥%d",self.viewModel.goodsInfoModel.goodsNewPrice];
    if (self.viewModel.isSecondsDeal) {
        self.goodsOldPrice.text = [NSString stringWithFormat:@"￥%d",self.viewModel.goodsInfoModel.goodsOldPrice];
        CGSize labelSize = [UILabel sizeWithLabel:self.goodsNewPrice];
        self.goodsNewPrice.bounds = CGRectMake( 0, 0, labelSize.width, labelSize.height);
        CGSize oldPriceLableSize = [UILabel sizeWithLabel:self.goodsOldPrice];
        self.goodsOldPrice.frame = CGRectMake( CGRectGetMaxX(self.goodsNewPrice.frame) + 5, CGRectGetMinY(self.goodsNewPrice.frame), oldPriceLableSize.width, oldPriceLableSize.height);
    }
    self.goodsSellNumber.text = [NSString stringWithFormat:@"%d人已购买",self.viewModel.goodsInfoModel.goodsSellNumber];
    
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:self.viewModel.shopModel.COMPANY_IMAGE_URL] placeholderImage:[UIImage imageNamed:@"not_load"]];
    self.shopImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shopImage.layer.borderWidth = 1;
    self.shopName.text = self.viewModel.shopModel.COMPANY_NAME;
    
    //如果没有参数，把参数view移除掉
    if (self.viewModel.dataArray.count == 0) {
        [self.goodsParamsView removeFromSuperview];
        self.goodsParamsView = nil;
    } else {
        [self setuiParamsView];
    }
    
    [self setupGoodsCountView];

    CGFloat originY = 0;
    
    if (self.goodsParamsView) {
        originY = CGRectGetMaxY(self.goodsParamsView.frame) + 5;

    }else {
        originY = CGRectGetMaxY(self.goodsInfoView.frame) + 5;
    }
    //数量view
    self.goodsCountView.frame = CGRectMake( 0, originY, KscreenW, 44);

    //评论
    self.goodsComment.frame = CGRectMake( 0, CGRectGetMaxY(self.goodsCountView.frame) + 5, KscreenW, 44);
    //详情
    self.goodsDetailView.frame = CGRectMake( 0, CGRectGetMaxY(self.goodsComment.frame) + 5, KscreenW, 44);
    
    self.shopView.frame = CGRectMake( 0, CGRectGetMaxY(self.goodsDetailView.frame) + 5, KscreenW, 64);
    
    if (CGRectGetMaxY(self.shopView.frame) < KscreenH) {
        self.shopView.frame = CGRectMake( 0, KscreenH - 64 - 64, KscreenW, 64);
    }
    self.baseView.contentSize = CGSizeMake(KscreenW, CGRectGetMaxY(self.shopView.frame) + 54 + 120);

    [self bindActionHandler];
}

- (void)paramsButtonClick:(TSParamsButton *)button{
    //////   确定选中的是哪个一个，，， 赋值非viewModel
    NSUInteger index = button.indexPath.section;
    TSGoodsParamsModel *paramsModel = self.viewModel.dataArray[index];
    //点击一下，创建一个参数对象     判断该参数是否已经加入过，。加入过，不在加入，paramsCount 不增加
    TSParametersList *newParams = [[TSParametersList alloc] init];
    newParams.parametersId = paramsModel.goodsParametersId;
    newParams.parametersName = button.titleLabel.text;
    //遍历已选中的参数
    TSParametersList *deleteParam = nil;
    for (TSParametersList *param in self.viewModel.paramsValue) {
        if (param.parametersId == newParams.parametersId) {
            deleteParam = param;
        }
    }
    if (deleteParam) {
        [self.viewModel.paramsValue removeObject:deleteParam];
        self.viewModel.paramsCount -= 1;
    }
    [self.viewModel.paramsValue addObject:newParams];
    self.viewModel.paramsCount += 1;
    NSLog(@"%@-----%@",paramsModel.goodsParametersName,newParams.parametersName);
    
}
#pragma mark - blind methods
- (void)normalBuy {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    for (TSParametersList *params in self.viewModel.paramsValue) {
        NSDictionary *dict = @{@"goodsParametersId" : [NSString stringWithFormat:@"%d",params.parametersId],
                               @"goodsParametersName" : params.parametersName};
        [arr addObject:dict];
    }
    NSDictionary *goodsInformation = nil;
    if (self.viewModel.isSecondsDeal) {
        NSArray *postArr = @[@{@"carId" : @"",
                               @"seckillId" : [NSString stringWithFormat:@"%d",self.viewModel.seckillModel.SecondsDeal_EventID],
                               @"goodsId" : [NSString stringWithFormat:@"%d",self.viewModel.goodsID],
                               @"price" : [NSString stringWithFormat:@"%d",self.viewModel.goodsInfoModel.goodsNewPrice],
                               @"number" : [NSString stringWithFormat:@"%d",self.viewModel.count],
                               @"goodsParameters" : @""}];
        goodsInformation = @{@"post" : postArr};

    }else {
        NSArray *postArr = @[@{@"carId" : @"",
                               @"seckillId" : @"",
                               @"goodsId" : [NSString stringWithFormat:@"%d",self.viewModel.goodsID],
                               @"price" : [NSString stringWithFormat:@"%d",self.viewModel.goodsInfoModel.goodsNewPrice],
                               @"number" : [NSString stringWithFormat:@"%d",self.viewModel.count],
                               @"goodsParameters" : @""}];
        goodsInformation = @{@"post" : postArr};
    }
    
    NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId],
                             @"goodsInformation" : [goodsInformation JSONString]};
    [TSHttpTool postWithUrl:OrderSure_URL params:params success:^(id result) {
        //            NSLog(@"购买：%@",result);
        if ([result[@"success"] intValue] == 1) {
            TSOrderConfirmViewModel *viewModel = [[TSOrderConfirmViewModel alloc] init];
            TSOrderConfirmViewController *orderConfirmVC = [[TSOrderConfirmViewController alloc] initWithViewModel:viewModel];
            [self.navigationController pushViewController:orderConfirmVC animated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"购买：%@",error);
    }];
}

- (void)bindActionHandler{
    @weakify(self);
    [self.minerBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.viewModel.count > 1) {
            int buyCount = self.viewModel.count - 1;
            [self.viewModel setCount:buyCount];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.plusBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.viewModel.count < 20) {
            int buyCount = self.viewModel.count + 1;
            [self.viewModel setCount:buyCount];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.goodsComment bk_whenTapped:^{
       @strongify(self);
        TSCommentViewModel *viewModel = [[TSCommentViewModel alloc] init];
        
        viewModel.goodsInfoModel = self.viewModel.goodsInfoModel;
        TSCommentViewController *commentVC = [[TSCommentViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:commentVC animated:YES];
    }];
    
    [self.goodsDetailView bk_whenTapped:^{
       @strongify(self);
        TSGoodsDesViewController *goodsDesVC = [[TSGoodsDesViewController alloc] init];
        goodsDesVC.goodsInfoModel = self.viewModel.goodsInfoModel;
        [self.navigationController pushViewController:goodsDesVC animated:YES];
    }];

    [self.enterShop bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
        viewModel.companyID = self.viewModel.shopModel.I_D;
        TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:shopDetailVC animated:YES];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSDictionary *params = @{@"userId" : @(self.userModel.userId),
                                 @"collectionType" : @"GOODS",
                                 @"collectionId" : @(self.viewModel.goodsID)};
        [TSHttpTool getWithUrl:Collection_URL params:params withCache:NO success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"收藏成功" delay:1];
            }else if ([result[@"errorMsg"] isEqualToString:@"have_collection"]) {
                [self showProgressHUD:@"该商品已经收藏了" delay:1];
            }else {
                [self showProgressHUD:@"收藏失败" delay:1];
            }
        } failure:^(NSError *error) {
            NSLog(@"商品收藏:%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.addShopCarButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.viewModel.paramsCount != self.viewModel.dataArray.count) {
            [self showProgressHUD:@"请选择参数" delay:1];
            return ;
        }

        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for (TSParametersList *params in self.viewModel.paramsValue) {
            NSDictionary *dict = @{@"goodsParametersId" : [NSString stringWithFormat:@"%d",params.parametersId],
                                   @"goodsParametersName" : params.parametersName};
            [arr addObject:dict];
        }
        NSDictionary *goodsParameters = @{@"result" : arr};
        NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId],
                                 @"goodsId" : [NSString stringWithFormat:@"%d",self.viewModel.goodsID],
                                 @"goodsParameters" : [goodsParameters JSONString],
                                 @"number" : [NSString stringWithFormat:@"%d",self.viewModel.count]};
        [TSHttpTool getWithUrl:ShopCarAdd_URL params:params withCache:NO success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"添加成功" delay:1];
            }
        } failure:^(NSError *error) {
            NSLog(@"加入购物车:%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.buyButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.viewModel.paramsCount != self.viewModel.dataArray.count) {
            [self showProgressHUD:@"请选择参数" delay:1];
            return ;
        }

        if (self.viewModel.isSecondsDeal) {
            //秒杀            
            ////

            NSDictionary *params = @{@"id" : [NSString stringWithFormat:@"%d",self.viewModel.seckillModel.S_ID]};
            [TSHttpTool getWithUrl:SeckillCheck params:params withCache:NO success:^(id result) {
                NSLog(@"秒杀商品数量:%@",result);
                [self normalBuy];

            } failure:^(NSError *error) {
                NSLog(@"秒杀商品数量:%@",error);
            }];
            
        }else {
            //购买
            [self normalBuy];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.naviRightBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSShopCarViewModel *viewModel = [[TSShopCarViewModel alloc] init];
        TSShopCarViewController *shopCarVC = [[TSShopCarViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:shopCarVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)blindViewModel{
//    @weakify(self);
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,count)
     options:NSKeyValueObservingOptionNew
     block:^(TSGoodsDetailViewController *observer, TSGoodsDetailViewModel *object, NSDictionary *change) {
//       @strongify(self);
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.count.text = [NSString stringWithFormat:@"%d",[[change objectForKey:NSKeyValueChangeNewKey] intValue]];
         }
    }];
    
//    [self.KVOController
//     observe:self.viewModel
//     keyPath:@keypath(self.viewModel,loadGoodsInfo)
//     options:NSKeyValueObservingOptionNew
//     block:^(id observer, id object, NSDictionary *change) {
//        
//    }];
//    
//    [self.KVOController
//     observe:self.viewModel
//     keyPath:@keypath(self.viewModel,loadGoodsInfo)
//     options:NSKeyValueObservingOptionNew
//     block:^(id observer, id object, NSDictionary *change) {
//         
//     }];

}

- (void)setupGoodsCountView{
    
    _countImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"secondDeal_countBg"]];
    _countImageView.userInteractionEnabled = YES;
    _countImageView.frame = CGRectMake( self.goodsCountView.frame.size.width - 20 - 80, CGRectGetMinY(self.countLabel.frame) - 3, 80, 30);
    [self.goodsCountView addSubview:_countImageView];
    
    _minerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _minerBtn.frame = CGRectMake( 0, 0, 25, 30);
    [_minerBtn setBackgroundImage:[UIImage imageNamedString:@"secondDeal_miner_bg"] forState:UIControlStateNormal];
    [_minerBtn setImage:[UIImage imageNamedString:@"secondDeal_miner"] forState:UIControlStateNormal];
    [_countImageView addSubview:_minerBtn];
    
    _count = [[UILabel alloc] init];
    _count.frame = CGRectMake( CGRectGetMaxX(_minerBtn.frame), 1, 30, 28);
    _count.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    _count.textColor = [UIColor blackColor];
    _count.text = [NSString stringWithFormat:@"%d",self.viewModel.count];
    _count.textAlignment = NSTextAlignmentCenter;
    [_countImageView addSubview:_count];
    
    _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _plusBtn.frame = CGRectMake( CGRectGetMaxX(_count.frame), 0, 25, 30);
    [_plusBtn setBackgroundImage:[UIImage imageNamedString:@"secondDeal_plus_bg"] forState:UIControlStateNormal];
    [_plusBtn setImage:[UIImage imageNamedString:@"secondDeal_plus"] forState:UIControlStateNormal];
    [_countImageView addSubview:_plusBtn];

}
@end
