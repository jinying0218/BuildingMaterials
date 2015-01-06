//
//  TSSecondDealDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/30.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondDealDetailViewController.h"
#import "TSSecondDealDetailViewModel.h"

static NSString *const SecondDealDetailCellIdentifier = @"SecondDealDetailCellIdentifier";

@interface TSSecondDealDetailViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSSecondDealDetailViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *goodName;
@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation TSSecondDealDetailViewController
- (instancetype)initWithViewModel:(TSSecondDealDetailViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];
    self.tabBarController.tabBar.hidden =  YES;

    [self bindHandler];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{

}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"秒杀详情" leftButtonImageName:@"Previous" rightButtonImageName:@"mine_shopBag"];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT - KbottomBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 45;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(UITableViewCell *cell,id taskModel,NSIndexPath *indexPath){
        if (indexPath.section == 1) {
            cell.textLabel.text = @"宝贝评价";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }else if (indexPath.section == 2){
            cell.textLabel.text = @"进入店铺";
        }else {
            cell.textLabel.text = @"商品属性";
            if (indexPath.row == 2) {
                
                UIImageView *countImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"secondDeal_countBg"]];
                countImageView.userInteractionEnabled = YES;
                countImageView.frame = CGRectMake( cell.frame.size.width - 20 - 69, 9, 69, 30);
                [cell.contentView addSubview:countImageView];
                
                UIButton *minerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                minerBtn.frame = CGRectMake( 0, 0, 23, 30);
                [minerBtn setBackgroundImage:[UIImage imageNamedString:@"secondDeal_miner_bg"] forState:UIControlStateNormal];
                [minerBtn setImage:[UIImage imageNamedString:@"secondDeal_miner"] forState:UIControlStateNormal];
                [countImageView addSubview:minerBtn];
                [minerBtn bk_addEventHandler:^(id sender) {
                    NSLog(@"减少");
                } forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *count = [[UILabel alloc] init];
                count.frame = CGRectMake( CGRectGetMaxX(minerBtn.frame), 1, 23, 28);
                count.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
                count.textColor = [UIColor blackColor];
                [countImageView addSubview:count];
                
                UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                plusBtn.frame = CGRectMake( CGRectGetMaxX(count.frame), 0, 23, 30);
                [plusBtn setBackgroundImage:[UIImage imageNamedString:@"secondDeal_plus_bg"] forState:UIControlStateNormal];
                [plusBtn setImage:[UIImage imageNamedString:@"secondDeal_plus"] forState:UIControlStateNormal];
                [countImageView addSubview:plusBtn];
                [plusBtn bk_addEventHandler:^(id sender) {
                    NSLog(@"增加");
                } forControlEvents:UIControlEventTouchUpInside];

            }
        
        }
    };
    
    
//    self.viewModel = [[TSArrayDataSource alloc] initWithNibName:@"TSSecondsDealDetailTableViewCell" items:self.tableDataArray cellIdentifier:SecondsDealDetailTableViewCell configureCellBlock:configureBlock];
    [self.viewModel configureTableViewWithNibName:nil cellIdentifier:SecondDealDetailCellIdentifier configureCellBlock:configureBlock];
    self.tableView.dataSource = self.viewModel;
    self.tableView.delegate = self;
    [self.rootView addSubview:self.tableView];
    
    
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    tableHeaderView.frame = CGRectMake( 0, 0, self.tableView.frame.size.width, 240);
    
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIScrollView *bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 180)];
    //    banner.showsVerticalScrollIndicator = NO;
    //    banner.showsHorizontalScrollIndicator = NO;
    bannerScrollView.contentSize = CGSizeMake( 3 * KscreenW, 180);
    bannerScrollView.delegate = self;
    bannerScrollView.pagingEnabled = YES;
    bannerScrollView.backgroundColor = [UIColor yellowColor];
    [tableHeaderView addSubview:bannerScrollView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView1.frame = CGRectMake( 0, 0, KscreenW, 180);
    [bannerScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView2.frame = CGRectMake( KscreenW, 0, KscreenW, 180);
    [bannerScrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"banner1"]];
    imageView3.frame = CGRectMake( KscreenW * 2, 0, KscreenW, 180);
    [bannerScrollView addSubview:imageView3];
    
    self.goodName = [[UILabel alloc] init];
    self.goodName.text = @"2014世纪末非瓷砖";
//    CGRect strSize = [self.goodName.text boundingRectWithSize:CGSizeMake( CGFLOAT_MAX, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:nil context:nil];
    CGSize strSize = [self.goodName sizeThatFits:CGSizeMake(CGFLOAT_MAX, 20)];

    self.goodName.frame = CGRectMake( 15, CGRectGetMaxY(bannerScrollView.frame) + 15, strSize.width, 20);
    self.goodName.font = [UIFont systemFontOfSize:15];
    [tableHeaderView addSubview:self.goodName];
//    self.goodName.backgroundColor = [UIColor redColor];

    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake( 15, CGRectGetMaxY(self.goodName.frame), tableHeaderView.frame.size.width - 100, 20)];
    price.text = @"￥138 568";
    price.font = [UIFont systemFontOfSize:13];
    [tableHeaderView addSubview:price];
    
    UIImageView *discountView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"discount"]];
    discountView.frame = CGRectMake( CGRectGetMaxX(self.goodName.frame), CGRectGetMinY(self.goodName.frame), 40, 22);
    [tableHeaderView addSubview:discountView];
    
    UILabel *seperatorLine = [[UILabel alloc] initWithFrame:CGRectMake( tableHeaderView.frame.size.width - 100, CGRectGetMaxY(bannerScrollView.frame) + 12, 1, 36)];
    seperatorLine.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    [tableHeaderView addSubview:seperatorLine];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyBtn.frame = CGRectMake( tableHeaderView.frame.size.width - 20 - 60, CGRectGetMaxY(bannerScrollView.frame) + 15, 60, 30);
    self.buyBtn.backgroundColor = [UIColor colorWithHexString:@"3cbff1"];
    [self.buyBtn setTitle:@"马上抢购" forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.buyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.buyBtn.layer.cornerRadius = 5;
    [tableHeaderView addSubview:self.buyBtn];
}
- (void)bindHandler{
    [self.buyBtn bk_addEventHandler:^(id sender) {
        NSLog(@"抢购");
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - tableView delegateMethod
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
