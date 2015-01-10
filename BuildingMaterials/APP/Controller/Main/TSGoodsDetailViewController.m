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

#import <UIImageView+WebCache.h>

@interface TSGoodsDetailViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *banner;//商品图片展示
@property (nonatomic, strong) IBOutlet UIScrollView *baseView;
@property (weak, nonatomic) IBOutlet UIButton *enterShopButton;//进入店铺
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
@property (weak, nonatomic) IBOutlet UILabel *goodsNewPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSellNumber;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *addShopCarButton;//加入购物车
@property (weak, nonatomic) IBOutlet UIButton *buyButton;//立即购买
@property (weak, nonatomic) IBOutlet UIView *goodsComment;  //商品评价
@property (weak, nonatomic) IBOutlet UILabel *goodsCommentCount;
@property (weak, nonatomic) IBOutlet UIView *goodsDetailView;
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIView *goodsStandardView;        //商品参数View

@property (weak, nonatomic) IBOutlet UIView *shopView;

@property (strong, nonatomic) UIImageView *goodsImageView;
@property (strong, nonatomic) UIButton *minerBtn;
@property (strong, nonatomic) UILabel *count;
@property (strong, nonatomic) UIButton *plusBtn;

@property (strong, nonatomic) UIImageView *countImageView;
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
//        NSLog(@"商品信息:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.shopModel setShopModelValueForDictionary:result[@"companyResult"]];
            [self.viewModel.goodsInfoModel setValueForDictionary:result[@"goodsResult"]];
            
            [self layoutSubviews];
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
            [self layoutSubviews];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"商品参数:%@",error);

    }];
}
#pragma mark - set up UI
- (void)setupUI{
    
//    [self creatRootView];
    [self createNavigationBarTitle:@"商品详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 130)];
    [self.banner addSubview:_goodsImageView];
    
    self.enterShopButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.enterShopButton.layer.borderWidth = 1;
    
    self.baseView.contentSize = CGSizeMake(KscreenW, CGRectGetMaxY(self.shopView.frame) + 54 + 120);
    
}

- (void)layoutSubviews{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.goodsInfoModel.goodsHeadImage]];
    
    self.goodsName.text = self.viewModel.goodsInfoModel.goodsName;
    self.goodsDes.text = self.viewModel.goodsInfoModel.goodsDesSimple;
    self.goodsNewPrice.text = [NSString stringWithFormat:@"%d",self.viewModel.goodsInfoModel.goodsNewPrice];
    self.goodsSellNumber.text = [NSString stringWithFormat:@"%d人已购买",self.viewModel.goodsInfoModel.goodsSellNumber];
    
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:self.viewModel.shopModel.COMPANY_IMAGE_URL]];
    self.shopImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shopImage.layer.borderWidth = 1;
    self.shopName.text = self.viewModel.shopModel.COMPANY_NAME;

    for (int i = 0; i < self.viewModel.dataArray.count; i ++) {
        TSGoodsParamsModel *oneParameterModel = self.viewModel.dataArray[i];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@:",oneParameterModel.goodsParametersName];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];

        CGSize fitLabelSize = [UILabel sizeWithLabel:label];
        label.frame = CGRectMake( 10, 10 + 50 * i, fitLabelSize.width, fitLabelSize.height);
        [self.goodsStandardView addSubview:label];
        
        for (int j = 0; j < oneParameterModel.parametersList.count; j ++ ) {
            TSParametersList *oneParam = oneParameterModel.parametersList[j];
            
//            CGRect titleSize = [oneParam.parametersName boundingRectWithSize:CGSizeMake( CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:oneParam.parametersName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"c9cbcb"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.frame = CGRectMake( CGRectGetMaxX(label.frame) + 30 + j * 90, 5 + 50 * i, 60, 30);
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 5;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.backgroundColor = [UIColor clearColor];
            [self.goodsStandardView addSubview:button];
        }
        
        UILabel *seperatorLine = [[UILabel alloc] initWithFrame:CGRectMake( 10, CGRectGetMaxY(label.frame) + 15, KscreenW - 20, 1)];
        seperatorLine.backgroundColor = [UIColor colorWithHexString:@"c9cbcb"];
        [self.goodsStandardView addSubview:seperatorLine];
        
        if ( i == self.viewModel.dataArray.count - 1) {
            [self setCountViewBelowSeperatorLine:seperatorLine];
        }
    }
    
    self.goodsStandardView.bounds = CGRectMake( 0, 0, KscreenW, CGRectGetMaxY(self.countImageView.frame) + 8);
}
- (void)bindActionHandler{
    @weakify(self);
    [self.minerBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSLog(@"减少");
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.plusBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSLog(@"增加");
    } forControlEvents:UIControlEventTouchUpInside];

}

- (void)setCountViewBelowSeperatorLine:(UILabel *)seperatorLine{
    
    _countImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"secondDeal_countBg"]];
    _countImageView.userInteractionEnabled = YES;
    _countImageView.frame = CGRectMake( self.goodsStandardView.frame.size.width - 20 - 80, CGRectGetMaxY(seperatorLine.frame) + 8, 80, 30);
    [self.goodsStandardView addSubview:_countImageView];
    
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
