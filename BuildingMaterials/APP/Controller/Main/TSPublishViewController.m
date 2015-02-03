//
//  TSPulishViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSPublishViewController.h"
#import "TSPublishViewModel.h"
#import "TSHttpTool.h"
#import "TSUserModel.h"

@interface TSPublishViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UITextViewDelegate>
@property (nonatomic, strong) TSPublishViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextView *contentInput;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (weak, nonatomic) IBOutlet UIScrollView *imageBackScrollview;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) TSUserModel *userModel;
@end

@implementation TSPublishViewController
- (instancetype)initWithViewModel:(TSPublishViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailizeData];
    [self setupUI];
    [self blindViewModel];
    [self blindActionHandler];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initailizeData{
    self.userModel = [TSUserModel getCurrentLoginUser];
}

#pragma mark - set UI
- (void)setupUI{
    [self createNavigationBarTitle:@"帖子发布" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviRightBtn setTitle:@"确认发布" forState:UIControlStateNormal];
    [self.naviRightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.naviRightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.naviRightBtn.frame = CGRectMake( KscreenW - 70, 0, 60, 44);
    [self.navigationBar addSubview:self.naviRightBtn];
    
    self.contentInput.layer.borderColor = [UIColor colorWithHexString:@"f0f0f0"].CGColor;
    self.contentInput.layer.borderWidth = 1;
    self.contentInput.layer.cornerRadius = 5;
    
    self.takePictureButton.layer.borderColor = [UIColor colorWithHexString:@"f0f0f0"].CGColor;
    self.takePictureButton.layer.borderWidth = 1;
    
    
    self.contentInput.delegate = self;

    self.imagePickerController = [[UIImagePickerController alloc] init];
    [self.imagePickerController setDelegate:self];
    [self.imagePickerController setAllowsEditing:NO];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];

    [self layoutSubviews];
}

- (void)layoutSubviews{
    UIImageView *lastView = nil;
    [self.viewModel.imageContent setString:@""];
    for (int i = 0; i < self.viewModel.imageArray.count; ++ i ) {
        UIImage *image = self.viewModel.imageArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        if (i <= 2) {
            imageView.frame = CGRectMake( i*74 , 0, 64, 64);
        }else {
            imageView.frame = CGRectMake( (i - 3) * 74, 74, 64, 64);
        }
        [self.imageBackScrollview addSubview:imageView];
        lastView = imageView;
    }
    if (lastView == nil) {
        self.takePictureButton.frame = CGRectMake( 0, 0, 64, 64);
    }else {
        self.takePictureButton.frame = CGRectMake( CGRectGetMaxX(lastView.frame) + 10, CGRectGetMinY(lastView.frame), 64, 64);
    }
    
    [self.viewModel.imageURLArray enumerateObjectsUsingBlock:^(NSString *imageURLString, NSUInteger idx, BOOL *stop) {
        NSMutableString *imageContent = [[NSMutableString alloc] initWithString:imageURLString];
        [imageContent insertString:@"<image src='" atIndex:0];
        [imageContent insertString:@"'style='width:100%'/>" atIndex:imageContent.length];
        
        [self.viewModel.imageContent appendString:imageContent];
    }];
    
    NSMutableString *mutableContent = [self.viewModel.contentInputString mutableCopy];
    [mutableContent insertString:@"<p>" atIndex:0];
    [mutableContent insertString:@"</p>" atIndex:mutableContent.length];
    
    self.viewModel.publishContent = [NSString stringWithFormat:@"%@%@",mutableContent,self.viewModel.imageContent];
}
- (void)blindViewModel{
    [self.KVOController observe:self keyPath:@keypath(self.viewModel,titleInputString) options:NSKeyValueObservingOptionNew block:^(TSPublishViewController *observer, TSPublishViewModel *object, NSDictionary *change) {
        if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
            observer.titleInput.text = change[NSKeyValueChangeNewKey];
        }
    }];
    
    [self.KVOController observe:self keyPath:@keypath(self.viewModel,contentInputString) options:NSKeyValueObservingOptionNew block:^(TSPublishViewController *observer, TSPublishViewModel *object, NSDictionary *change) {
        if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
            observer.contentInput.text = change[NSKeyValueChangeNewKey];
        }
    }];

}
- (void)blindActionHandler{
    @weakify(self);
    [self.takePictureButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.viewModel.imageArray.count == 6) {
            [self showProgressHUD:@"最多上传六张" delay:1];
            return ;
        }
        [self.actionSheet showInView:[UIApplication sharedApplication].keyWindow];

    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleInput bk_addEventHandler:^(UITextField *textField) {
        @strongify(self);
        [self.viewModel setTitleInputString:textField.text];
    } forControlEvents:UIControlEventEditingChanged];
    
    [self.naviRightBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        NSDictionary *params = @{@"forumName" : self.viewModel.titleInputString,
                                 @"forumContent" : self.viewModel.publishContent,
                                 @"forumClassifyId" : @(self.viewModel.forumClassifyId),
                                 @"userId" : @(self.userModel.userId)};
        [TSHttpTool postWithUrl:ForumSave_URL params:params success:^(id result) {
            NSLog(@"发帖子:%@",result);
            if ([result[@"success"] intValue] == 1) {
                [self showProgressHUD:@"发布成功" delay:1];

                dispatch_time_t poptime =
                dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
                dispatch_after(poptime, dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });

            }
            
        } failure:^(NSError *error) {
            NSLog(@"发帖子:%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - textView Delegate
- (void)textViewDidChange:(UITextView *)textView{
    [self.viewModel setContentInputString:textView.text];
}
#pragma mark - UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:self.imagePickerController animated:YES completion:NULL];
            
        }
            break;
        case 1:{
            [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:self.imagePickerController animated:YES completion:NULL];
        }
            break;
        default:
            break;
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:NULL];

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    image = [UIImage imageWithData:imageData];
    if (self.viewModel.imageArray.count < 6) {
        [self.viewModel.imageArray addObject:image];
    }

    NSString *baseImage = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *params = @{@"photo" : baseImage};
    [TSHttpTool postWithUrl:ImageUpload_URL params:params success:^(id result) {
        NSLog(@"图片上传结果:%@",result);
        if ([result[@"success"] intValue] == 1) {
            if (self.viewModel.imageURLArray.count < 6) {
                [self.viewModel.imageURLArray addObject:result[@"url"]];
            }
            [self layoutSubviews];
        }
    } failure:^(NSError *error) {
        NSLog(@"图片上传结果:%@",error);
    }];

    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

- (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = CWSizeReduce(image.size, length);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}
static inline CGSize CWSizeReduce(CGSize size, CGFloat limit){   // 按比例减少尺寸
    
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    return imgSize;
}

@end
