//
//  TSPayViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/8.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSPayViewController.h"
#import "TSGoodsDetailViewController.h"
#import "TSShopCarViewController.h"
#import "TSWaitForPayViewController.h"

@interface TSPayViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@end

@implementation TSPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [self blindActionHandler];
    [self initializeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initializeData{
    if (self.orderCode) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?orderCode=%@",Pay_URL,self.orderCode]]]];
    }else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?orderId=%d&&orderCode=%@",Pay_URL,self.orderId,@""]]]];
//        NSLog(@"%@",[NSString stringWithFormat:@"%@?orderId=%d&&orderCode=",Pay_URL,self.orderId]);
    }
    
}
- (void)configureUI{
    [self createNavigationBarTitle:@"支付宝支付" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
}
- (void)leftButtonClick:(UIButton *)button{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        //            NSLog(@"%@",controller);
        if ([controller isKindOfClass:[TSGoodsDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }else if ([controller isKindOfClass:[TSShopCarViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
        }else if ([controller isKindOfClass:[TSWaitForPayViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)blindViewModel{
    
}
- (void)blindActionHandler{
    @weakify(self);
    
    [self.webView bk_setDidStartLoadBlock:^(UIWebView *webView) {
        @strongify(self);
        [self showProgressHUD];
    }];
    [self.webView bk_setDidFinishLoadBlock:^(UIWebView *webView) {
        @strongify(self);
        [self hideProgressHUD];
    }];

    
}
- (IBAction)backItemClick:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)nextItemClick:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

@end
