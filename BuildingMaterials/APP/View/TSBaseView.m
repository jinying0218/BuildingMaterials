//
//  TSBaseView.m
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSBaseView.h"
#import "MBProgressHUD.h"

#define BottomLeftBtn_tag 9000
#define BottomRightBtn_tag 9001

@interface TSBaseView ()
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@end

@implementation TSBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setupTableView:(UITableView *)tableView nibName:(NSString *)nibName dataSourceArray:(NSArray *)arrayDataSource cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)configureCellBlock
{
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:nibName items:arrayDataSource cellIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
    tableView.dataSource = self.dataSource;
    tableView.delegate = self;
    [self addSubview:tableView];
}

- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake( 0, self.frame.size.height - KbottomBarHeight, KscreenW, KbottomBarHeight)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#8cceb8"];
    [self addSubview:bottomView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.tag = BottomLeftBtn_tag;
    leftBtn.frame = CGRectMake( 0, 0, KscreenW/2, KbottomBarHeight);
    [leftBtn setImage:[UIImage imageNamedString:@"reported_btn"] forState:UIControlStateNormal];

    [leftBtn setImage:[UIImage imageNamedString:@"task_btn"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamedString:@"task_btn_selected"] forState:UIControlStateSelected];

    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake( 3, 65, 16, 65)];
    [leftBtn setTitle:@"任务" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"#DEF0EA"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateSelected];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake( 33, 0, 0, 62)];
    [leftBtn addTarget:self action:@selector(bottomLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:leftBtn];
    leftBtn.selected = YES;

    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake( KscreenW/2, 0, KscreenW/2, KbottomBarHeight);
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.tag = BottomRightBtn_tag;
    [rightBtn setImage:[UIImage imageNamedString:@"reported_btn"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamedString:@"reported_btn_selected"] forState:UIControlStateSelected];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake( 3, 65, 16, 65)];
    [rightBtn setTitle:@"报事" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#DEF0EA"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateSelected];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake( 33, 0, 0, 62)];
    [rightBtn addTarget:self action:@selector(bottomRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
}
- (void)bottomLeftButtonClick:(UIButton *)button
{
    button.selected = YES;
    UIButton *rightBtn = (UIButton *)[self viewWithTag:BottomRightBtn_tag];
    rightBtn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(bottomLeftButtonClick:)]) {
        [self.delegate bottomLeftButtonClick:button];
    }

}
- (void)bottomRightButtonClick:(UIButton *)button
{
    button.selected = YES;
    UIButton *leftBtn = (UIButton *)[self viewWithTag:BottomLeftBtn_tag];
    leftBtn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(bottomRightButtonClick:)]) {
        [self.delegate bottomRightButtonClick:button];
    }
}


#pragma mark - 提示框
- (void)showProgressHUD:(NSString *)content delay:(double)delaySeconds
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = content;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
    dispatch_after(poptime, dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}
- (void)showProgressHUD
{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}
- (void)hideProgressHUD
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

@end
