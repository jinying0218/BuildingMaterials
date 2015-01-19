//
//  TSGoodsDesViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/17.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsDesViewController.h"

@interface TSGoodsDesViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TSGoodsDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializeData{
}
#pragma mark - set up UI
- (void)setupUI{

    [self createNavigationBarTitle:self.goodsInfoModel.goodsName leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.webView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.webView loadHTMLString:self.goodsInfoModel.goodsDes baseURL:nil];
//    NSLog(@"商品描述:%@",self.goodsInfoModel.goodsDes);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"%s",__func__);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"%s",__func__);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%s",__func__);
}
@end
