//
//  CustomTableViewCell.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UIButton *menuImageButton;

@property (weak, nonatomic) IBOutlet UILabel *menuType;
@property (weak, nonatomic) IBOutlet UILabel *menuPrice;
@property (weak, nonatomic) IBOutlet UIButton *menuSelectButton;

+ (CGFloat)rowHeight;

@end
