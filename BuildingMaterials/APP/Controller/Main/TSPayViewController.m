//
//  TSPayViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/8.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSPayViewController.h"

@interface TSPayViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TSPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self configureUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initializeData{
}
- (void)configureUI{
    
    [self createNavigationBarTitle:@"支付宝支付" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
}

- (void)blindViewModel{
    
}
- (void)blindActionHandler{
}

@end
