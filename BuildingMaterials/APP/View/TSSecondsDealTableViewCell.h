//
//  TSSecondsDealTableViewCell.h
//  BuildingMaterials
//
//  Created by Ariel on 14/10/27.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPLabel.h"
#import "MZTimerLabel.h"

@protocol SecondsDealTableViewCellDelegate <NSObject>

- (void)touchCellImageView:(UIButton *)button;

@end

@interface TSSecondsDealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fristGoodsImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondGoodsImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdGoodsImage;
@property (weak, nonatomic) IBOutlet UILabel *fristGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *secondGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *thirdGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *fristGoodsNowPrice;
@property (weak, nonatomic) IBOutlet UILabel *secondGoodsNowPrice;
@property (weak, nonatomic) IBOutlet UILabel *thirdGoodsNowPrice;
@property (weak, nonatomic) IBOutlet LPLabel *fristGoodsPrice;
@property (weak, nonatomic) IBOutlet LPLabel *secondGoodsPrice;
@property (weak, nonatomic) IBOutlet LPLabel *thirdGoodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstImageButton;
@property (weak, nonatomic) IBOutlet UIButton *secondImageButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdImageButton;

@property (strong, nonatomic) MZTimerLabel *mzTimerLabel;
@property (nonatomic, weak) id<SecondsDealTableViewCellDelegate> delegate ;

- (void)configureCellWithModelArray:(NSMutableArray *)models;
@end
