//
//  TSWaitForPayViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSWaitForPayViewController.h"
#import "TSWaitForPayViewModel.h"

@interface TSWaitForPayViewController ()
@property (nonatomic, strong) TSWaitForPayViewModel *viewModel;
@end

@implementation TSWaitForPayViewController

- (instancetype)initWithViewModel:(TSWaitForPayViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self configureUI];
    [self blindViewModel];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData{
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;
    
    [self createNavigationBarTitle:@"待付订单" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];

}

- (void)blindViewModel{
    
}
- (void)blindActionHandler{
}
@end
