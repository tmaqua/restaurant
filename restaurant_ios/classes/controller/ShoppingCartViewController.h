//
//  ShoppingCartViewController.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

@interface ShoppingCartViewController : UIViewController

@property (nonatomic) Menu *selectedMenu;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
