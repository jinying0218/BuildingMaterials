//
//  TSMainTabBarViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSMainTabBarViewController.h"
#import "TSBaseViewController.h"
#import "TSFristViewModel.h"
#import "TSCategoryViewModel.h"
#import "TSForumViewModel.h"
#import "TSInviteViewModel.h"
#import "TSMineViewModel.h"

@interface TSMainTabBarViewController ()

@end

@implementation TSMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbarController];
    
//    UIImage *bgImage = [UIImage imageNamedString:@"tabbar_bg"];
//    [bgImage resizeImageWithNewSize:CGSizeMake(self.tabBar.frame.size.width, 49)];
//    self.tabBar.backgroundImage = bgImage;
//    self.tabBar.backgroundColor = [UIColor colorWithHexString:@"1DA6DF"];
//    self.tabBar.barTintColor = [UIColor colorWithHexString:@"1DA6DF"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createTabbarController
{
    //获得Data.plist文件全路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBarControllers.plist" ofType:nil];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];

    NSMutableArray *controllerArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        //获得要创建的类名
        NSString *className = [dict objectForKey:CLASS_NAME_KEY];
        //从类名转换成类对象(Class)
        Class class = NSClassFromString(className);
        if (class) {
            NSObject *viewModel;
            if ([className isEqualToString:@"TSFristViewController"]) {
                viewModel = [[TSFristViewModel alloc] init];
            }else if ([className isEqualToString:@"TSCategoryViewController"]){
                viewModel = [[TSCategoryViewModel alloc] init];
            }else if ([className isEqualToString:@"TSForumViewController"]){
                viewModel = [[TSForumViewModel alloc] init];
            }else if ([className isEqualToString:@"TSInviteViewController"]){
                viewModel = [[TSInviteViewModel alloc] init];
            }else if ([className isEqualToString:@"TSMineViewController"]){
                viewModel = [[TSMineViewModel alloc] init];
            }
            
            //创建指定的类实例
            TSBaseViewController *rvc = [[class alloc] initWithDict:dict];
            rvc.viewModel = viewModel;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:rvc];
            [controllerArray addObject:nc];
        }
    }
    self.viewControllers = controllerArray;
}
@end
