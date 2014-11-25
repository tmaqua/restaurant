//
//  MenuViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // CoreData All Delete
//    [EatList MR_truncateAll];
//    [Food MR_truncateAll];
    
    // navbar change color
    self.navigationController.navigationBar.barTintColor =
        [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self initHeaderButton];
    
    _menuTable.delegate = self;
    _menuTable.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"MenuTableCell" bundle:nil];
    [_menuTable registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    _refreshControl = [UIRefreshControl new];
    [_menuTable addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(refreshOccured:) forControlEvents:UIControlEventValueChanged];
    _menuTable.alwaysBounceVertical = YES;

    
    [self getDataFromServer];
}

- (void)initHeaderButton {
    // shopping button
    [_shoppingButton setBackgroundImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    _shoppingButton.tag = 6;
    [_shoppingButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // all button
    [_allButton setBackgroundColor:[UIColor colorWithRed:0.54 green:0.41 blue:0.33 alpha:1.0]];
    _allButton.tag = 1;
    [_allButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // don button
    [_donButton setBackgroundColor:[UIColor colorWithRed:0.87 green:0.45 blue:0.40 alpha:1.0]];
    _donButton.tag = 2;
    [_donButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // maindish button
    [_maindishButton setBackgroundColor:[UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0]];
    _maindishButton.tag = 3;
    [_maindishButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // sidedish button
    [_sidedishButton setBackgroundColor:[UIColor colorWithRed:0.73 green:0.75 blue:0.00 alpha:1.0]];
    _sidedishButton.tag = 4;
    [_sidedishButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // other button
    // 6E7EDB
    [_otherButton setBackgroundColor:[UIColor colorWithRed:0.36 green:0.69 blue:0.56 alpha:1.0]];
    _otherButton.tag = 5;
    [_otherButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // save button
    [_saveButton setBackgroundColor:[UIColor colorWithRed:0.43 green:0.49 blue:0.86 alpha:1.0]];
    [_saveButton addTarget:self action:@selector(saveMenuData:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.enabled = NO;
    _saveButton.alpha = 0.3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_menuArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Menu *menu = [_menuArray objectAtIndex:indexPath.row];
    
    // set menu title
    cell.menuTitle.text = menu.name;
    
    // set menu picture
    NSString *image_path = menu.image_path;
    if ([image_path  isEqual: @""]) {
        UIImage *srcImage = [UIImage imageNamed:@"noimage.jpg"];
        if (menu.isSoldout) {
            [cell.menuImageButton setBackgroundImage:[self getBrightnessImage:srcImage] forState:UIControlStateNormal];
            [cell.menuImageButton setTitle:@"売り切れ" forState:UIControlStateNormal];
            [cell.menuImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else {
            [cell.menuImageButton setTitle:@"" forState:UIControlStateNormal];
            [cell.menuImageButton setBackgroundImage:srcImage forState:UIControlStateNormal];
        }
        [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        NSURL *url = [NSURL URLWithString:image_path];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (menu.isSoldout) {
                    [cell.menuImageButton setBackgroundImage:[self getBrightnessImage:downloadedImage] forState:UIControlStateNormal];
                    [cell.menuImageButton setTitle:@"売り切れ" forState:UIControlStateNormal];
                    [cell.menuImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }else {
                    [cell.menuImageButton setTitle:@"" forState:UIControlStateNormal];
                    [cell.menuImageButton setBackgroundImage:downloadedImage forState:UIControlStateNormal];
                }
                [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
            });
        }];
        [getImageTask resume];
    }
    
    // set menu type
    cell.menuType.text = [menu getCategoryName:menu.category];
    switch (menu.category) {
        case 0:
            cell.menuType.backgroundColor = [UIColor colorWithRed:0.87 green:0.45 blue:0.40 alpha:1.0];
            break;
        case 1:
            cell.menuType.backgroundColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
            break;
        case 2:
            cell.menuType.backgroundColor = [UIColor colorWithRed:0.73 green:0.75 blue:0.00 alpha:1.0];
            break;
        case 3:
            cell.menuType.backgroundColor = [UIColor colorWithRed:0.36 green:0.69 blue:0.56 alpha:1.0];
            break;
        default:
            break;
    }
    cell.menuType.textColor = [UIColor whiteColor];
    cell.menuType.layer.cornerRadius = 6;
    
    // set menu price
    NSString *price = [NSString stringWithFormat:@"%ld", (long)menu.price];
    cell.menuPrice.text = [NSString stringWithFormat:@"%@%@",@"￥",price];
    
    if (menu.isSoldout) {
        [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"nonselect.png"] forState:UIControlStateNormal];
    } else {
        [cell.menuSelectButton addTarget:self action:@selector(selectMenuItem:event:) forControlEvents:UIControlEventTouchUpInside];
        if (menu.isSelect) {
            [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"subButton.png"] forState:UIControlStateNormal];
        } else {
            [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"addButton.png"] forState:UIControlStateNormal];
        }
    }
    
    
    
    return cell;
}

- (void)calcSumPrice {
    Menu *menu = nil;
    NSInteger sumPrice = 0;
    for (int i=0; i<[_srcArray count]; i++) {
        menu = [_srcArray objectAtIndex:i];
        if (menu.isSelect) {
            sumPrice += menu.price;
        }
    }

    NSString *price = [NSString stringWithFormat:@"%ld", (long)sumPrice];
    _sumPriceLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",price];
}

-(void)reloadViewAll {
    [self calcSumPrice];
    [_menuTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomTableViewCell rowHeight];
}

- (UIImage *)getBrightnessImage:(UIImage *)srcImage {
    // UIImage -> GPUImage
    GPUImagePicture *imagePicture = [[GPUImagePicture alloc] initWithImage:srcImage];
    // grayscale filter alloc
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    // set brightness value
    [brightnessFilter setBrightness:-0.3];
    // add filter
    [imagePicture addTarget:brightnessFilter];
    // run filter
    [imagePicture processImage];
    // get UIImage
    UIImage *outputImage = [brightnessFilter imageByFilteringImage:srcImage];
    
    return outputImage;
}

- (void)transToDetail:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    _selectedMenu = indexPath.row;
    [self performSegueWithIdentifier:@"toDetailSegue" sender:self];
}


- (void)selectMenuItem:(UIButton *)sender event:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    Menu *menu = [_menuArray objectAtIndex:indexPath.row];
    if (!menu.isSoldout) {
        menu.isSelect = !menu.isSelect;
    }
    
    [self reloadViewAll];
}

- (NSIndexPath *)indexPathForControlEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint p = [touch locationInView:_menuTable];
    NSIndexPath *indexPath = [_menuTable indexPathForRowAtPoint:p];
    return indexPath;
}

- (void)selectCategory:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSPredicate *predicate;
    _menuArray = _srcArray;
    _saveButton.enabled = NO;
    _saveButton.alpha = 0.3;
    
    switch (button.tag) {
        case 1:
            break;
        case 2:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"category", @0];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 3:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"category", @1];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 4:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"category", @2];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 5:
            predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"category", @3];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        case 6:
            _saveButton.enabled = YES;
            _saveButton.alpha = 1.0;
            predicate = [NSPredicate predicateWithFormat:@"isSelect = YES"];
            _menuArray = [_menuArray filteredArrayUsingPredicate:predicate];
            break;
        default:
            break;
    }
    
    [_menuTable reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toDetailSegue"]) {
        Menu *menu = [_menuArray objectAtIndex:_selectedMenu];
        DetailViewController *vc = (DetailViewController*)[segue destinationViewController];
        vc.detailMenu = menu;
    }
}

- (void)saveMenuData:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelect = YES"];
    NSArray *selectedArray = [_menuArray filteredArrayUsingPredicate:predicate];
    
    if ([selectedArray count] == 0) {
        [SVProgressHUD showErrorWithStatus:@"何も選択されていません"];
    } else {
        NSDate *today = [self getDateSZero:[NSDate date]];
        int unixtime = [today timeIntervalSince1970];
        
        EatList *eatList = [EatList MR_createEntity];
        eatList.ate_at = [NSNumber numberWithInteger:unixtime];
        for (int i = 0; i < [selectedArray count]; i++) {
            Food *food = [Food MR_createEntity];
            Menu *menu = [selectedArray objectAtIndex:i];
            food.food_id = [NSNumber numberWithInteger:menu.id];
            food.name = menu.name;
            food.category = [NSNumber numberWithInteger:menu.category];
            food.price = [NSNumber numberWithInteger:menu.price];
            food.red = [NSNumber numberWithFloat:menu.red];
            food.green = [NSNumber numberWithFloat:menu.green];
            food.yellow = [NSNumber numberWithFloat:menu.yellow];
            food.image_path = menu.image_path;
            [eatList addFoodObject:food];
        }
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if (success) {
//                NSLog(@"successfully saved");
                for (int i=0; i<[_menuArray count]; i++) {
                    Menu *menu = _menuArray[i];
                    menu.isSelect = NO;
                }
                [SVProgressHUD showSuccessWithStatus:@"保存しました"];
                _saveButton.enabled = NO;
                _saveButton.alpha = 0.3;
                [self reloadViewAll];
                
            } else if (error) {
//                NSLog(@"Error saving context: %@", error.description);
                [SVProgressHUD showErrorWithStatus:@"保存に失敗しました"];
                _saveButton.enabled = NO;
                _saveButton.alpha = 0.3;
                [self reloadViewAll];
            }
        }];
    }
}

- (NSDate*)getDateSZero:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:flags fromDate:date];
    
    return [calendar dateFromComponents:components];
}

- (void)getDataFromServer {
    
    if (![PDUtils isConnectNetwork]) {
        [PDUtils alertDialog:NOT_CONNECT_NETWORK delegate:self];
        return;
    }
    NSDate *today = [self getDateSZero:[NSDate date]];
    NSString *unixtime = @"1398351600";
//    NSString *unixtime = [NSString stringWithFormat:@"%d",(int)[today timeIntervalSince1970]];
    NSString *params = [@"?date=" stringByAppendingString:unixtime];
    [ExtendedPDAPIConnection getMessages:10.0f params:params completeBlock:^(NSArray *messages) {
        [SVProgressHUD show];
        
        MenuList *temp = messages[0];
        NSDictionary *tempDict = [@{@"menus":temp.menus}mutableCopy];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i=0; i< [tempDict[@"menus"] count]; i++) {
            Menu *menu = Menu.new;
            menu.id = [tempDict[@"menus"][i][@"food"][@"id"] intValue];
            menu.name = tempDict[@"menus"][i][@"food"][@"name"];
            menu.price = [tempDict[@"menus"][i][@"food"][@"price"] intValue];
            menu.image_path = tempDict[@"menus"][i][@"food"][@"image_path"];
            menu.category = [tempDict[@"menus"][i][@"food"][@"category"] intValue];
            menu.green = [tempDict[@"menus"][i][@"food"][@"green"] floatValue];
            menu.red = [tempDict[@"menus"][i][@"food"][@"red"] floatValue];
            menu.yellow = [tempDict[@"menus"][i][@"food"][@"yellow"] floatValue];
            menu.isSoldout = [tempDict[@"menus"][i][@"is_soldout"] intValue];
            menu.isSelect = NO;
            [tempArray addObject:menu];
        }
        
        _srcArray = [tempArray mutableCopy];
        _menuArray = _srcArray;
        
        [SVProgressHUD dismiss];
        [self reloadViewAll];
        
    } errorBlock:^(int errorCode, NSString *errorMessage) {
        [SVProgressHUD show];
        int j = 0;
        NSLog(@"\nERROR! :%@", errorMessage);
        NSMutableArray *dummyArray = [NSMutableArray array];
        for (int i=0; i< 15; i++) {
            Menu *menu = Menu.new;
            menu.id = i;
            menu.name = [@"DUMMY" stringByAppendingString:[NSString stringWithFormat:@"%d",i]];
            menu.price = (i+1)*100;
            if (i%2 == 0) {
                menu.image_path = @"";
            } else {
                menu.image_path = @"http://food.foto.ne.jp/free/resize.php?image=images/images_big/yos0024-054.jpg";
            }
            
            if (j > 3) {
                j = 0;
            }
            menu.category = j;
            menu.green = 0.1;
            menu.red = 0.2;
            menu.yellow = 0.3;
            if (i%3 == 0) {
                menu.isSoldout = YES;
            } else {
                menu.isSoldout = NO;
            }
            menu.isSelect = NO;
            [dummyArray addObject:menu];
            j++;
        }
        _srcArray = [dummyArray mutableCopy];
        _menuArray = _srcArray;
        
        [SVProgressHUD dismiss];
        [self reloadViewAll];
        
    } cancelBlock:^{
        
    }];
}

- (void)refreshOccured:(id)sender
{
    [self.refreshControl beginRefreshing];
    [self getDataFromServer];
    [self.refreshControl endRefreshing];
}

@end
