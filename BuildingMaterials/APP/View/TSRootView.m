//
//  TSRootView.m
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSRootView.h"
#import "TSUserModel.h"

static  NSString *const rootCellIdentifier = @"rootCell";

@interface TSRootView ()

@end
@implementation TSRootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setupRootTableView
{
    self.arrayDataSource = [NSMutableArray arrayWithObjects:@"数据上传",@"版本更新",@"关于我们",@"退出登录", nil];
    self.rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    self.rootTableView.rowHeight = 49;
    self.rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CellConfigureBlock configureBlock = ^(UITableViewCell *cell,NSString *title,NSIndexPath *indexPath){
        cell.textLabel.text = title;
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = [UIColor colorWithHexString:@"#e4e4e4"];
        }else{
            cell.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        }
    };
    [self setupTableView:self.rootTableView nibName:nil dataSourceArray:self.arrayDataSource cellIdentifier:rootCellIdentifier cellConfigureBlock:configureBlock];
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 200, 90)];
    tableHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f6f3ee"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 15, 20, 19, 19)];
    [imageView setImage:[UIImage imageNamedString:@"more_user"]];
    [tableHeaderView addSubview:imageView];
    
    UILabel *departmentLabel = [[UILabel alloc] init];
    switch ([TSUserModel getCurrentLoginUser].departmentTypeId) {
        case 1:
        {
                departmentLabel.text = @"管理人员";
        }
            break;
        case 2:
        {
                departmentLabel.text = @"工程人员";
        }
            break;
        case 3:
        {
                departmentLabel.text = @"安保人员";
        }
            break;
        default:
            break;
    }

    departmentLabel.textColor = [UIColor colorWithHexString:@"#d74a3d"];
    departmentLabel.font = [UIFont systemFontOfSize:16];
    departmentLabel.frame = CGRectMake( CGRectGetMaxX(imageView.frame)+ 10, 22, 100, 18);
    [tableHeaderView addSubview:departmentLabel];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.font = [UIFont systemFontOfSize:15];
    userNameLabel.text = [NSString stringWithFormat:@"您好，%@",[TSUserModel getCurrentLoginUser].userName];
    userNameLabel.textColor = [UIColor colorWithHexString:@"#d74a3d"];
    userNameLabel.frame = CGRectMake( 15, CGRectGetMaxY(imageView.frame) + 15, 100, 18);
    [tableHeaderView addSubview:userNameLabel];

    
    self.rootTableView.tableHeaderView = tableHeaderView;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(rootViewItemClick:)]) {
        [self.delegate rootViewItemClick:indexPath];
    }
}
@end
