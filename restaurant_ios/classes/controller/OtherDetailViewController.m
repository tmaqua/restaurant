//
//  OtherDetailViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "OtherDetailViewController.h"

@interface OtherDetailViewController ()

@end

@implementation OtherDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navbar change color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
