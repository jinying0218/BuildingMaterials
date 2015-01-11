//
//  TSExchangeDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSExchangeDetailViewController.h"

#import "TSReleaseExchangeViewController.h"
#import "TSReleaseEchangeViewModel.h"
#import <UIImageView+WebCache.h>
#import "TSUserModel.h"
#import "TSImageModel.h"

@interface TSExchangeDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *baseView;

@property (weak, nonatomic) IBOutlet UIScrollView *thingsBanner;
@property (weak, nonatomic) IBOutlet UILabel *thingName;
@property (weak, nonatomic) IBOutlet UILabel *thingDes;
@property (weak, nonatomic) IBOutlet UILabel *wantThing;
@property (weak, nonatomic) IBOutlet UILabel *thingNew;
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *telPhone;
@property (weak, nonatomic) IBOutlet UIButton *telButton;
@property (weak, nonatomic) IBOutlet UIButton *releaseButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

@end

@implementation TSExchangeDetailViewController

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
    
    NSDictionary *params = @{@"id" : [NSString stringWithFormat:@"%d",self.viewModel.exchangeGoodsModel.I_D]};
//    [TSHttpTool getWithUrl:ExchangeDetail_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"换物详情：%@",result);
//        if ([result[@"success"] intValue] == 1) {
//            
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"换物详情:%@",error);
//    }];
    
    [TSHttpTool getWithUrl:ExchangeImage_URL params:params withCache:NO success:^(id result) {
        NSLog(@"换物图片：%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSImageModel *model = [[TSImageModel alloc] init];
                [model setValueWithDict:dict];
                [self.viewModel.imageArray addObject:model];
            }
            [self layoutSubviews];
        }
    } failure:^(NSError *error) {
        NSLog(@"换物图片:%@",error);
    }];

}
#pragma mark - set up UI
- (void)setupUI{
    
    //    [self creatRootView];
    [self createNavigationBarTitle:@"换物详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    NSLog(@"%@",self.thingsBanner);
    
//    _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 130)];
//    [self.banner addSubview:_goodsImageView];
    
//    self.enterShopButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.enterShopButton.layer.borderWidth = 1;
    
//    self.baseView.contentSize = CGSizeMake(KscreenW, CGRectGetMaxY(self.shopView.frame) + 54 + 120);
    
}

- (void)layoutSubviews{
    self.thingsBanner.contentSize = CGSizeMake( KscreenW * self.viewModel.imageArray.count, 130);
    int i = 0;
    for (TSImageModel *imageModel in self.viewModel.imageArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( KscreenW * i, 0, KscreenW, 130)];
        if (![imageModel.imageUrl isEqual:[NSNull null]]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.imageUrl]];
        }
        [self.thingsBanner addSubview:imageView];
        i ++;
    }
    
    self.thingName.text = self.viewModel.exchangeGoodsModel.THINGS_NAME;
    self.thingDes.text = self.viewModel.exchangeGoodsModel.THINGS_DES;
    self.wantThing.text = self.viewModel.exchangeGoodsModel.THINGS_WANTS;
    self.thingNew.text = self.viewModel.exchangeGoodsModel.THING_NEWS;
    self.releaseTime.text = self.viewModel.exchangeGoodsModel.EXCHANGE_TIME;
    self.address.text = self.viewModel.exchangeGoodsModel.THINGS_AREA;
    self.telPhone.text = self.viewModel.exchangeGoodsModel.THINGS_TEL_PHONE;

    self.baseView.contentSize = CGSizeMake( KscreenW, CGRectGetMaxY(self.releaseButton.frame) + 15);
}
- (void)bindActionHandler{
    @weakify(self);
    //拨打电话
    [self.telButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.viewModel.exchangeGoodsModel.EXCHANGE_TIME]]];

    } forControlEvents:UIControlEventTouchUpInside];
    //发布换物
    [self.releaseButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSReleaseEchangeViewModel *viewModel = [[TSReleaseEchangeViewModel alloc] init];
        TSReleaseExchangeViewController *releaseExchangeVC = [[TSReleaseExchangeViewController alloc] init];
        releaseExchangeVC.viewModel = viewModel;
        [self.navigationController pushViewController:releaseExchangeVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //举报
    [self.reportButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSUserModel *userModel = [TSUserModel getCurrentLoginUser];
        NSDictionary *params = @{@"reportContent":@"",
                                 @"userId":[NSString stringWithFormat:@"%d",userModel.userId],
                                 @"reportType":@"EXCHANGE",
                                 @"reportId":[NSString stringWithFormat:@"%d",self.viewModel.exchangeGoodsModel.I_D]};
        [TSHttpTool getWithUrl:Invite_PostRepor_URL params:params withCache:NO success:^(id result) {
            NSLog(@"举报换物:%@",result);
            if( [result[@"success"] intValue] == 1 ){
                [self showProgressHUD:@"举报成功" delay:1];
            }else if ([result[@"success"] intValue] == 0 && [result[@"errorMsg"] isEqualToString:@"have_report"]){
                [self showProgressHUD:@"已经举报过" delay:1];
            };
        } failure:^(NSError *error) {
            NSLog(@"举报换物：%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
@end
