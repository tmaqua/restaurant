//
//  EatenFoodViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/16.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "EatenFoodViewController.h"


@interface EatenFoodViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation EatenFoodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _foodTable.delegate = self;
    _foodTable.dataSource = self;
    
    // navbar change color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    
    UINib *nib = [UINib nibWithNibName:@"MenuTableCell" bundle:nil];
    [_foodTable registerNib:nib forCellReuseIdentifier:@"Cell"];
//    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    [_foodTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_eatenFoods count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomTableViewCell rowHeight];
}

- (void)transToDetail:(UIButton *)sender event:(UIEvent *)event {
    //    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    [self performSegueWithIdentifier:@"toDetailSegue" sender:self];
}

@end
