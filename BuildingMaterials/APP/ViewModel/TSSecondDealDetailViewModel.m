//
//  TSSecondDealDetailViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/30.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondDealDetailViewModel.h"
@interface TSSecondDealDetailViewModel ()
@property(nonatomic, strong) NSString *nibName;
@property(nonatomic, strong) NSString *cellIdentifier;
@property(nonatomic, strong) CellConfigureBlock configureCellBlock;

@end
@implementation TSSecondDealDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableDataArray = [[NSMutableArray alloc] initWithObjects:@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖", nil];
    }
    return self;
}


#pragma mark - setter method
- (void)configureTableViewWithNibName:(NSString *)nibName cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CellConfigureBlock)aConfigureCellBlock{
    self.nibName = nibName;
    self.cellIdentifier = aCellIdentifier;
    self.configureCellBlock = aConfigureCellBlock;
    
    
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return @"4444";
    //self.tableDataArray[indexPath.row];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
    //self.tableDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        default:
            return 1;
            break;
    }
//    return 3;
    //[self.tableDataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if (self.nibName) {
        UINib *nib = [UINib nibWithNibName:self.nibName bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:self.cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        //        cell.backView.frame = CGRectMake( 5, 5, 277, 50);
    }else {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
        }
    }
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}

@end
