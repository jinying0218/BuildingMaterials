//
//  TSReleaseExchangeViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSReleaseExchangeViewController.h"

@interface TSReleaseExchangeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *baseView;
@property (weak, nonatomic) IBOutlet UIButton *releaseButton;
@property (weak, nonatomic) IBOutlet UITextField *thingNameInput;
@property (weak, nonatomic) IBOutlet UITextField *thingNewInput;
@property (weak, nonatomic) IBOutlet UITextField *thingWantInput;
@property (weak, nonatomic) IBOutlet UITextField *contactAdressInput;
@property (weak, nonatomic) IBOutlet UITextField *contactUserNameInput;
@property (weak, nonatomic) IBOutlet UITextField *contactTelInput;
@property (weak, nonatomic) IBOutlet UITextView *thingDesInput;

@property (weak, nonatomic) IBOutlet UIImageView *thingFirstImage;
@property (weak, nonatomic) IBOutlet UIImageView *thingSecondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thingThirdImage;
@property (weak, nonatomic) IBOutlet UIButton *firstAddImageButton;
@property (weak, nonatomic) IBOutlet UIButton *secondAddImageButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdAddImageButton;

@property (strong, nonatomic) UIActionSheet *sheet;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@property (assign, nonatomic) int imageCount;

@end

@implementation TSReleaseExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
    [self blindViewModel];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    
    [self createNavigationBarTitle:@"换物发布" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.thingDesInput.delegate = self;
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    [self.imagePickerController setAllowsEditing:YES];
    self.imagePickerController.delegate = self;
    
    
    self.sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"相册", nil];

}

- (void)layoutSubViews{
    self.thingNameInput.text = self.viewModel.thingName;
    self.thingNewInput.text = self.viewModel.thingNew;
    self.thingWantInput.text = self.viewModel.thingWant;
    self.contactAdressInput.text = self.viewModel.contactAddress;
    self.contactUserNameInput.text = self.viewModel.contactUserName;
    self.contactTelInput.text = self.viewModel.contactTel;
}

- (void)blindViewModel{
//    @weakify(self);
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,thingName)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController *observer, TSReleaseEchangeViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.thingNameInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
    }];
    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,thingWant)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController * observer, TSReleaseEchangeViewModel * object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.thingWantInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }

     }];
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,thingNew)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController * observer, TSReleaseEchangeViewModel * object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.thingNewInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }

     }];
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,contactAddress)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController * observer, TSReleaseEchangeViewModel * object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.contactAdressInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,contactUserName)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController * observer, TSReleaseEchangeViewModel * object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.contactUserNameInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,contactTel)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController * observer, TSReleaseEchangeViewModel * object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.contactTelInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];
    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,thingDes)
     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
     block:^(TSReleaseExchangeViewController * observer, TSReleaseEchangeViewModel * object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.thingDesInput.text = [change objectForKey:NSKeyValueChangeNewKey];
         }
     }];

    
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,buttonIndex)
     options:NSKeyValueObservingOptionNew
     block:^(TSReleaseExchangeViewController *observer, TSReleaseEchangeViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             if (self.viewModel.imageArray.count == 3) {
                 [self.viewModel.imageArray removeObjectAtIndex:[[change objectForKey:NSKeyValueChangeNewKey] intValue]];
                 [self.viewModel.urlArray removeObjectAtIndex:[[change objectForKey:NSKeyValueChangeNewKey] intValue]];
             }
         }
    }];
}

- (void)blindActionHandler{
    @weakify(self);
    [self.firstAddImageButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.sheet showInView:self.view];
        self.viewModel.buttonIndex = 0;
        if (![self.thingFirstImage.image isEqual:[NSNull null]]) {
            self.thingFirstImage.image = nil;
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.secondAddImageButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.sheet showInView:self.view];
        self.viewModel.buttonIndex = 1;
        if (![self.thingSecondImage.image isEqual:[NSNull null]]) {
            self.thingSecondImage.image = nil;
        }
    } forControlEvents:UIControlEventTouchUpInside];

    [self.thirdAddImageButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.sheet showInView:self.view];
        self.viewModel.buttonIndex = 2;
        if (![self.thingThirdImage.image isEqual:[NSNull null]]) {
            self.thingThirdImage.image = nil;
        }
    } forControlEvents:UIControlEventTouchUpInside];

    
    [self.thingNameInput bk_addEventHandler:^(UITextField *sender) {
        @strongify(self);
        [self.viewModel setThingName:sender.text];
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.thingNewInput bk_addEventHandler:^(UITextField *sender) {
        @strongify(self);
        [self.viewModel setThingNew:sender.text];
    } forControlEvents:UIControlEventEditingChanged];

    [self.thingWantInput bk_addEventHandler:^(UITextField *sender) {
        @strongify(self);
        [self.viewModel setThingWant:sender.text];
    } forControlEvents:UIControlEventEditingChanged];

    [self.contactAdressInput bk_addEventHandler:^(UITextField *sender) {
        @strongify(self);
        [self.viewModel setContactAddress:sender.text];
    } forControlEvents:UIControlEventEditingChanged];

    [self.contactUserNameInput bk_addEventHandler:^(UITextField *sender) {
        @strongify(self);
        [self.viewModel setContactUserName:sender.text];
    } forControlEvents:UIControlEventEditingChanged];

    [self.contactTelInput bk_addEventHandler:^(UITextField *sender) {
        @strongify(self);
        [self.viewModel setContactTel:sender.text];
    } forControlEvents:UIControlEventEditingChanged];

    
    [self.releaseButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.viewModel.thingName == nil ||
            self.viewModel.thingNew == nil ||
            self.viewModel.thingWant == nil ||
            self.viewModel.contactAddress == nil ||
            self.viewModel.contactTel == nil ||
            self.viewModel.contactUserName == nil ||
            self.viewModel.thingDes == nil) {
            [self showProgressHUD:@"请填写完整信息" delay:1.5];
        }else {
            NSString *imageString = [self.viewModel.urlArray componentsJoinedByString:@","];
            NSDictionary *params = @{@"name" : self.viewModel.thingName,
                                     @"news" : self.viewModel.thingNew,
                                     @"want" : self.viewModel.thingWant,
                                     @"address" : self.viewModel.contactAddress,
                                     @"userName" : self.viewModel.contactUserName,
                                     @"telphone" : self.viewModel.contactTel,
                                     @"des" : self.viewModel.thingDes,
                                     @"exchangeImage" : imageString};
            [TSHttpTool postWithUrl:ExchangeAdd_URL params:params success:^(id result) {
                NSLog(@"发布换物:%@",result);
                if ([result[@"success"] intValue] == 1) {
                    [self showProgressHUD:@"发布成功" delay:1];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                NSLog(@"发布换物:%@",error);
            }];
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - textView delegate
- (void)textViewDidChange:(UITextView *)textView{
    [self.viewModel setThingDes:textView.text];
}
#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
        }else {
            NSLog(@"相机不可用");
        }
    }else if (buttonIndex == 1) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    if (self.thingFirstImage.image == nil) {
        [self.thingFirstImage setImage:self.viewModel.imageArray[0]];
    } else if (self.thingSecondImage.image == nil) {
        [self.thingSecondImage setImage:self.viewModel.imageArray[1]];
    } else if (self.thingThirdImage.image == nil) {
        [self.thingThirdImage setImage:self.viewModel.imageArray[2]];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

#pragma mark - imagePickerController delegate
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType{
    self.imagePickerController.sourceType = sourceType;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    image = [UIImage imageWithData:imageData];
    
    NSString *baseImage = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *params = @{@"photo" : baseImage};
    [TSHttpTool postWithUrl:ImageUpload_URL params:params success:^(id result) {
        NSLog(@"图片上传结果:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.urlArray addObject:result[@"url"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"图片上传结果:%@",error);
    }];
    
    [self.viewModel.imageArray addObject:image];
    if (self.thingFirstImage.image == nil) {
        [self.thingFirstImage setImage:image];
    }else if (self.thingSecondImage.image == nil){
        [self.thingSecondImage setImage:image];
    }else if (self.thingThirdImage.image == nil) {
        [self.thingThirdImage setImage:image];
    }

    [self dismissViewControllerAnimated:YES completion:NULL];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
