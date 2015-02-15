//
//  TSForumDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/23.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSForumDetailViewController.h"
#import "TSReplyViewController.h"

#import <UIImageView+WebCache.h>

@interface TSForumDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UILabel *forumTitle;
@property (weak, nonatomic) IBOutlet UIImageView *forumClassifyImage;
@property (weak, nonatomic) IBOutlet UILabel *forumClassifyName;
@property (weak, nonatomic) IBOutlet UILabel *commentNumber;
@property (weak, nonatomic) IBOutlet UILabel *forumUser;

@end

@implementation TSForumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initailizeData];
    [self setupUI];
    
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initailizeData{
}

#pragma mark - set UI
- (void)setupUI{
    
    [self createNavigationBarTitle:@"帖子详情" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.forumTitle.text = self.forumClassifyModel.forum_content_title;
    self.commentNumber.text = [NSString stringWithFormat:@"%d",self.forumClassifyModel.forum_content_comment_number];
    [self.forumClassifyImage sd_setImageWithURL:[NSURL URLWithString:self.forumClassifyImageURL]];
    
    self.forumUser.text = self.forumClassifyModel.forum_user;
    
    [self.webView loadHTMLString:self.forumClassifyModel.forum_content baseURL:nil];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
}
- (void)blindActionHandler{
    @weakify(self);
    [self.bottomButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSReplyViewController *replyVC = [[TSReplyViewController alloc] init];
        replyVC.forumId = self.forumClassifyModel.forum_Id;
        [self.navigationController pushViewController:replyVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}
@end
