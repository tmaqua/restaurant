//
//  EatenFoodViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/16.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "EatenFoodViewController.h"
#import "TableViewConst.h"
#import "CustomTableViewCell.h"
#import "Menu.h"

@interface EatenFoodViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation EatenFoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _foodTable.delegate = self;
    _foodTable.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [_foodTable registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    _eatenFoods = [NSArray arrayWithObjects:
                  [Menu initMenu:0 title:@"title0" type:@"type0" price:100 isSoldout:YES isSelect:YES],
                  [Menu initMenu:1 title:@"title1" type:@"type1" price:200 isSoldout:YES isSelect:NO],
                  [Menu initMenu:2 title:@"title2" type:@"type2" price:300 isSoldout:NO isSelect:YES],
                  [Menu initMenu:3 title:@"title3" type:@"type3" price:400 isSoldout:NO isSelect:NO],
                  nil];
    
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
    
    Menu *menu = nil;
    menu = [_eatenFoods objectAtIndex:indexPath.row];
    
    cell.menuTitle.text = menu.title;
    
    // get picture
    UIImage *srcImage = [UIImage imageNamed:@"image.jpg"];
    [cell.menuImageButton setBackgroundImage:srcImage forState:UIControlStateNormal];
    [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.menuType.text = menu.type;
    cell.menuType.backgroundColor = [UIColor blueColor];
    cell.menuType.textColor = [UIColor whiteColor];
    cell.menuType.layer.cornerRadius = 6;
    
    cell.menuPrice.text = [NSString stringWithFormat:@"%ld", (long)menu.price];
    
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
