//
//  EatListViewController.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+SelectDateButton.h"
#import "EatenFoodViewController.h"
#import "Food.h"
#import "EatList.h"


@interface EatListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *listDayButton;
@property (weak, nonatomic) IBOutlet UIButton *listWeekButton;

@property (weak, nonatomic) IBOutlet UILabel *todayDate;

@property (weak, nonatomic) IBOutlet UIButton *weekButton0;
@property (weak, nonatomic) IBOutlet UIButton *weekButton1;
@property (weak, nonatomic) IBOutlet UIButton *weekButton2;
@property (weak, nonatomic) IBOutlet UIButton *weekButton3;
@property (weak, nonatomic) IBOutlet UIButton *weekButton4;
@property (weak, nonatomic) IBOutlet UIButton *weekButton5;
@property (weak, nonatomic) IBOutlet UIButton *weekButton6;

@property (weak, nonatomic) IBOutlet UILabel *weekLabel7;
@property (weak, nonatomic) IBOutlet UILabel *dateUnderBar2;
@property (weak, nonatomic) IBOutlet UILabel *dateUnderBar1;
@property (weak, nonatomic) IBOutlet UILabel *todayPrice;
@property (weak, nonatomic) IBOutlet UILabel *weekPrice;

@property (nonatomic) NSInteger weekSelectNum;
@property (nonatomic) NSMutableArray *selectedWeeks;
@property (nonatomic) UIImage *selectedImage;
@property (nonatomic) UIImage *nonselectImage;
@property (nonatomic) NSArray *eatlists;

@property (nonatomic) NSMutableArray *eatListsFromDay;
@property (nonatomic) NSMutableArray *eatListsFromWeek;

- (IBAction)backButton:(id)sender;
- (IBAction)newxtButton:(id)sender;

@end
