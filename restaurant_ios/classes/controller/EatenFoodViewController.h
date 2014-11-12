//
//  EatenFoodViewController.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/16.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Food.h"
#import "Menu.h"
#import "DetailViewController.h"

@interface EatenFoodViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *foodTable;

@property (nonatomic) NSArray *eatenFoods;
@property (nonatomic) NSMutableArray *eatenFoodsMenuModel;
@property (nonatomic) NSInteger selectedMenu;

@end
