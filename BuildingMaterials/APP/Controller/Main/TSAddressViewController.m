//
//  TSAddressViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSAddressViewController.h"
#import "TSAddressViewModel.h"
#import "TSUserModel.h"
#import "TSAddressModel.h"

static NSString *const AddressCellIdentifier = @"addressCellIdentifier";

@interface TSAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSAddressViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *cover;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameInput;
@property (weak, nonatomic) IBOutlet UITextField *contactTelNumberInput;
@property (weak, nonatomic) IBOutlet UITextField *addressInput;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (nonatomic, strong) TSUserModel *userModel;
@end

@implementation TSAddressViewController
- (instancetype)initWithViewModel:(TSAddressViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden =  YES;
    [self initializeData];
    [self setupUI];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initializeData{
    self.userModel = [TSUserModel getCurrentLoginUser];
    NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
    [TSHttpTool getWithUrl:Address_URL params:params withCache:NO success:^(id result) {
        NSLog(@"获取地址:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.addressArray removeAllObjects];
            for (NSDictionary *dict in result[@"result"]) {
                TSAddressModel *model = [[TSAddressModel alloc] init];
                [model setValueWithDict:dict];
                [self.viewModel.addressArray addObject:model];
            }
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"获取地址:%@",error);
    }];
}

#pragma mark - set up UI
- (void)setupUI{
    [self createNavigationBarTitle:@"地址管理" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.addressView.frame = CGRectMake( 0, KscreenH, KscreenW, 207);
}
- (void)blindViewModel{
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,nameString)
     options:NSKeyValueObservingOptionNew
     block:^(TSAddressViewController *observer, TSAddressViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.userNameInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
    }];
    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,nameString)
     options:NSKeyValueObservingOptionNew
     block:^(TSAddressViewController *observer, TSAddressViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.userNameInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];

    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,telNumber)
     options:NSKeyValueObservingOptionNew
     block:^(TSAddressViewController *observer, TSAddressViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.contactTelNumberInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];

    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,addressString)
     options:NSKeyValueObservingOptionNew
     block:^(TSAddressViewController *observer, TSAddressViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.addressInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];

}

- (void)blindActionHandler{
    @weakify(self);
    [self.bottomButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.cover.hidden = !self.cover.hidden;
        self.addressView.hidden = !self.addressView.hidden;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.addressView.frame;
            frame.origin.y = KscreenH - 207;
            self.addressView.frame = frame;
        } completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.saveButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSString *addressMain = [NSString stringWithFormat:@"%@ %@ %@",self.viewModel.addressString,self.viewModel.telNumber,self.viewModel.nameString];
        NSDictionary *params = @{@"addressMain" : addressMain,
                                 @"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
        [TSHttpTool postWithUrl:AddressSave_URL params:params success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.cover.hidden = !self.cover.hidden;
                    CGRect frame = self.addressView.frame;
                    frame.origin.y = KscreenH;
                    self.addressView.frame = frame;
                } completion:^(BOOL finished) {
                    if (finished) {
                        self.addressView.hidden = !self.addressView.hidden;
                    }
                }];
                
                self.viewModel.nameString = @"";
                self.viewModel.telNumber = @"";
                self.viewModel.addressString = @"";
                
            }
        } failure:^(NSError *error) {
            NSLog(@"保存地址：%@",error);
        }];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [UIView animateWithDuration:0.25 animations:^{
            self.cover.hidden = !self.cover.hidden;
            CGRect frame = self.addressView.frame;
            frame.origin.y = KscreenH;
            self.addressView.frame = frame;
        } completion:^(BOOL finished) {
            if (finished) {
                self.addressView.hidden = !self.addressView.hidden;
            }
        }];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.userNameInput bk_addEventHandler:^(UITextField *userNameInput) {
        @strongify(self);
        [self.viewModel setNameString:userNameInput.text];
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.contactTelNumberInput bk_addEventHandler:^(UITextField *userNameInput) {
        @strongify(self);
        [self.viewModel setTelNumber:userNameInput.text];
    } forControlEvents:UIControlEventEditingChanged];

    [self.addressInput bk_addEventHandler:^(UITextField *userNameInput) {
        @strongify(self);
        [self.viewModel setAddressString:userNameInput.text];
    } forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake( 0, tableView.rowHeight - 1, KscreenW, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
        
//        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        cell.editingAccessoryView = deleteBtn;
        
//        cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    TSAddressModel *model = self.viewModel.addressArray[indexPath.row];
    cell.textLabel.text = model.addressMain;
    return cell;
}
#pragma mark - tableview  delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TSAddressModel *model = self.viewModel.addressArray[indexPath.row];
        NSDictionary *params = @{@"addressId" : [NSString stringWithFormat:@"%d",model.addressId],
                                 @"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
        [TSHttpTool getWithUrl:AddressDelete_URL params:params withCache:NO success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
                NSLog(@"删除地址：%@",result);
                [UIView animateWithDuration:0.25 animations:^{
                    self.cover.hidden = !self.cover.hidden;
                    CGRect frame = self.addressView.frame;
                    frame.origin.y = KscreenH;
                    self.addressView.frame = frame;
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self.viewModel.addressArray removeObjectAtIndex:indexPath.row];
                        self.cover.hidden = !self.cover.hidden;
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//                        [self.tableView reloadData];
                    }
                }];
                
                self.viewModel.nameString = @"";
                self.viewModel.telNumber = @"";
                self.viewModel.addressString = @"";
            }
        } failure:^(NSError *error) {
            
        } ];
    }
}

@end
