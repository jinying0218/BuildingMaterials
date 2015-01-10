//
//  TSExchangeDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSExchangeDetailViewController.h"
#import <UIImageView+WebCache.h>

@interface TSExchangeDetailViewController ()
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
    
}
#pragma mark - set up UI
- (void)setupUI{
    
    //    [self creatRootView];
    [self createNavigationBarTitle:@"换物详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 130)];
    [self.thingsBanner addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.exchangeGoodsModel.THINGS_HEAD_IMAGE]];
    
    
//    _goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 130)];
//    [self.banner addSubview:_goodsImageView];
    
//    self.enterShopButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.enterShopButton.layer.borderWidth = 1;
    
//    self.baseView.contentSize = CGSizeMake(KscreenW, CGRectGetMaxY(self.shopView.frame) + 54 + 120);
    
}

- (void)layoutSubviews{
    
}
- (void)bindActionHandler{
    
}
@end
