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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
    
    UINib *nib = [UINib nibWithNibName:@"MenuTableCell" bundle:nil];
    [_foodTable registerNib:nib forCellReuseIdentifier:@"Cell"];
//    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];

    [self transFoodModelToMenuModel];
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
    
    Menu *menu = [_eatenFoodsMenuModel objectAtIndex:indexPath.row];
    // set menu title
    cell.menuTitle.text = menu.name;
    
    // set menu picture
    NSString *image_path = menu.image_path;
    UIImage *srcImage;
    if ([image_path  isEqual: @""]) {
        srcImage = [UIImage imageNamed:@"noimage.jpg"];
        [cell.menuImageButton setBackgroundImage:srcImage forState:UIControlStateNormal];
        [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        NSURL *url = [NSURL URLWithString:image_path];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.menuImageButton setBackgroundImage:downloadedImage forState:UIControlStateNormal];
                [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
            });
        }];
        [getImageTask resume];
    }
    
    // set menu type
    cell.menuType.text = [menu getCategoryName:menu.category];
    cell.menuType.backgroundColor = [UIColor blueColor];
    cell.menuType.textColor = [UIColor whiteColor];
    cell.menuType.layer.cornerRadius = 6;
    
    // set menu price
    NSString *price = [NSString stringWithFormat:@"%ld", (long)menu.price];
    cell.menuPrice.text = [NSString stringWithFormat:@"%@%@",@"￥",price];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomTableViewCell rowHeight];
}

- (NSIndexPath *)indexPathForControlEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint p = [touch locationInView:_foodTable];
    NSIndexPath *indexPath = [_foodTable indexPathForRowAtPoint:p];
    return indexPath;
}

- (void)transToDetail:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    _selectedMenu = indexPath.row;
    [self performSegueWithIdentifier:@"toDetailSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toDetailSegue"]) {
        Menu *menu = [_eatenFoodsMenuModel objectAtIndex:_selectedMenu];
        DetailViewController *vc = (DetailViewController*)[segue destinationViewController];
        vc.detailMenu = menu;
    }
}

- (void)transFoodModelToMenuModel{
    NSMutableArray *menus = [NSMutableArray array];
    for (int i =0; i<[_eatenFoods count]; i++) {
        Menu *menu = Menu.new;
        Food *food = [_eatenFoods objectAtIndex:i];
        
        menu.id = [food.food_id intValue];
        menu.name = food.name;
        menu.price = [food.price intValue];
        menu.category = [food.category intValue];
        menu.green = [food.green floatValue];
        menu.red = [food.red floatValue];
        menu.yellow = [food.yellow floatValue];
        menu.image_path = food.image_path;
        menu.isSelect = NO;
        menu.isSoldout = NO;
        
        menu.calory = [food.calory floatValue];
        menu.salt = [food.salt floatValue];
        
        [menus addObject:menu];
    }
    _eatenFoodsMenuModel = menus;
}

@end
