//
//  TSArrayDataSource.m
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSArrayDataSource.h"

@interface TSArrayDataSource()
@property (nonatomic, strong) NSString *nibName;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) CellConfigureBlock configureCellBlock;
@end
@implementation TSArrayDataSource
- (id)init
{
    return nil;
}

- (id)initWithNibName:(NSString *)nibName items:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.nibName = nibName;
        self.dataSource = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource objectAtIndex:indexPath.row];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];

    if (self.nibName) {
        UINib *nib = [UINib nibWithNibName:self.nibName bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:self.cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    }else{
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
        }
    }

    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell,item,indexPath);
    return cell;
}


@end
