//
//  MenuViewController.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <UIKit/UIKit.h>


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


@end
