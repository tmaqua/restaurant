//
//  MenuViewController.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "GPUImage.h"
#import "DetailViewController.h"

#import "PDUtils.h"
#import "ExtendedPDAPIConnection.h"
#import "MenuList.h"
#import "Menu.h"
#import "Food.h"
#import "EatList.h"


@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *menuTable;

// header buttons
@property (weak, nonatomic) IBOutlet UIButton *shoppingButton;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *donButton;
@property (weak, nonatomic) IBOutlet UIButton *maindishButton;
@property (weak, nonatomic) IBOutlet UIButton *sidedishButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

@property (weak, nonatomic) IBOutlet UILabel *sumPriceLabel;
- (IBAction)saveButton:(id)sender;

@property (nonatomic) NSInteger selectedMenu;
@property (nonatomic) NSArray *menuArray;
@property (nonatomic) NSArray *srcArray;
@property (nonatomic) NSArray *messageArray;

@property (nonatomic) UIRefreshControl *refreshControl;


@end
