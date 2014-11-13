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
    [EatList MR_truncateAll];
    [Food MR_truncateAll];
    
    // navbar change color
    self.navigationController.navigationBar.barTintColor =
        [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    
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
    [_shoppingButton setBackgroundImage:[UIImage imageNamed:@"shoppingcart128.png"] forState:UIControlStateNormal];
    [_shoppingButton setBackgroundColor:[UIColor whiteColor]];
    _shoppingButton.tag = 6;
    [_shoppingButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // all button
    // FFA846
    [_allButton setBackgroundColor:[UIColor colorWithRed:1.0 green:0.659 blue:0.275 alpha:1.0]];
    _allButton.tag = 1;
    [_allButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // don button
    // DB766F
    [_donButton setBackgroundColor:[UIColor colorWithRed:0.859 green:0.463 blue:0.435 alpha:1.0]];
    _donButton.tag = 2;
    [_donButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // maindish button
    // A8E06E
    [_maindishButton setBackgroundColor:[UIColor colorWithRed:0.659 green:0.878 blue:0.431 alpha:1.0]];
    _maindishButton.tag = 3;
    [_maindishButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // sidedish button
    // DB766F
    [_sidedishButton setBackgroundColor:[UIColor colorWithRed:0.859 green:0.463 blue:0.435 alpha:1.0]];
    _sidedishButton.tag = 4;
    [_sidedishButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    // other button
    // 6E7EDB
    [_otherButton setBackgroundColor:[UIColor colorWithRed:0.431 green:0.494 blue:0.859 alpha:1.0]];
    _otherButton.tag = 5;
    [_otherButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
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
    UIImage *srcImage;
    if ([image_path  isEqual: @""]) {
        srcImage = [UIImage imageNamed:@"image.jpg"];
        if (menu.isSoldout) {
            [cell.menuImageButton setBackgroundImage:[self getBrightnessImage:srcImage] forState:UIControlStateNormal];
            [cell.menuImageButton setTitle:@"売り切れ" forState:UIControlStateNormal];
            [cell.menuImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else {
            [cell.menuImageButton setBackgroundImage:srcImage forState:UIControlStateNormal];
        }
        [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        NSString *urlString = @"http://airan-tamago.up.n.seesaa.net/airan-tamago/image/gazou201556.jpg";
        NSURL *url = [NSURL URLWithString:urlString];
        
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
                    [cell.menuImageButton setBackgroundImage:downloadedImage forState:UIControlStateNormal];
                }
                [cell.menuImageButton addTarget:self action:@selector(transToDetail:event:) forControlEvents:UIControlEventTouchUpInside];
            });
        }];
        [getImageTask resume];
//        srcImage = [UIImage imageNamed:@"image.jpg"];
    }
    
    // set menu type
    cell.menuType.text = [menu getCategoryName:menu.category];
    cell.menuType.backgroundColor = [UIColor blueColor];
    cell.menuType.textColor = [UIColor whiteColor];
    cell.menuType.layer.cornerRadius = 6;
    
    // set menu price
    NSString *price = [NSString stringWithFormat:@"%ld", (long)menu.price];
    cell.menuPrice.text = [NSString stringWithFormat:@"%@%@",@"￥",price];
    
    [cell.menuSelectButton addTarget:self action:@selector(selectMenuItem:event:) forControlEvents:UIControlEventTouchUpInside];

    if (menu.isSelect) {
        [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
    } else {
        [cell.menuSelectButton setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
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
    menu.isSelect = !menu.isSelect;
    
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
//        Menu *menu = [_srcArray objectAtIndex:_selectedMenu];
        Menu *menu = [_menuArray objectAtIndex:_selectedMenu];
        DetailViewController *vc = (DetailViewController*)[segue destinationViewController];
        vc.detailMenu = menu;
    }
}

- (IBAction)saveButton:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelect = YES"];
    NSArray *selectedArray = [_menuArray filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", selectedArray);
    
    if ([selectedArray count] == 0) {
        NSLog(@"\n***** No Select *****");
    } else {
        NSDate *today = [self getDateSZero:[NSDate date]];
        int unixtime = [today timeIntervalSince1970];
        
        NSLog(@"UNIXTIME: %d", unixtime);
        
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
                NSLog(@"successfully saved");
                for (int i=0; i<[_menuArray count]; i++) {
                    Menu *menu = _menuArray[i];
                    menu.isSelect = NO;
                }
                [self reloadViewAll];
                
//                NSArray *test = [self findDataInDay:[NSNumber numberWithInt:unixtime]];
//                EatList *foods = test[0];
//                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"food_id" ascending:YES];
//                NSArray *sortDescriptor = [NSArray arrayWithObject:sort];
//                NSArray *food = [[foods.food sortedArrayUsingDescriptors:sortDescriptor]mutableCopy];
//                NSLog(@"\n\n\nTEST: \n%@", food);
                
            } else if (error) {
                NSLog(@"Error saving context: %@", error.description);
            }
        }];
    }
}

//- (NSArray*)findDataInDay:(NSNumber*)day{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ate_at == %@", day];
//    return [EatList MR_findAllWithPredicate:predicate];
//}

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
    NSString *params = [@"?date=" stringByAppendingString:@"1398351600"];
    [ExtendedPDAPIConnection getMessages:10.0f params:params completeBlock:^(NSArray *messages) {
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
            
//            NSLog(@"id: %ld", (long)menu.id);
//            NSLog(@"name: %@", menu.name);
//            NSLog(@"price: %ld", (long)menu.price);
//            NSLog(@"image_path: %@", menu.image_path);
//            NSLog(@"category: %ld", (long)menu.category);
//            NSLog(@"categoryName: %@", [menu getCategoryName:menu.category]);
//            NSLog(@"green: %f", menu.green);
//            NSLog(@"red: %f", menu.red);
//            NSLog(@"yellow: %f", menu.yellow);
//            NSLog(@"isSoldout: %hhd", menu.isSoldout);
//            NSLog(@"isSelect: %hhd", menu.isSelect);
            [tempArray addObject:menu];
        }
        
        _srcArray = [tempArray mutableCopy];
        _menuArray = _srcArray;
        [self reloadViewAll];
        
    } errorBlock:^(int errorCode, NSString *errorMessage) {
        NSLog(@"\nERROR! :%@", errorMessage);
        NSMutableArray *dummyArray = [NSMutableArray array];
        for (int i=0; i< 3; i++) {
            Menu *menu = Menu.new;
            menu.id = i;
            menu.name = @"DUMMY";
            menu.price = (i+1)*100;
            menu.image_path = @"";
            menu.category = i;
            menu.green = 0.1;
            menu.red = 0.2;
            menu.yellow = 0.3;
            menu.isSoldout = NO;
            menu.isSelect = NO;
            [dummyArray addObject:menu];
        }
        _srcArray = [dummyArray mutableCopy];
        _menuArray = _srcArray;
        [self reloadViewAll];
        
    } cancelBlock:^{
        
    }];
}

- (void)refreshOccured:(id)sender
{
    if (![PDUtils isConnectNetwork]) {
        [PDUtils alertDialog:NOT_CONNECT_NETWORK delegate:self];
        return;
    }
    NSString *params = [@"?date=" stringByAppendingString:@"1398351600"];
    [ExtendedPDAPIConnection getMessages:10.0f params:params completeBlock:^(NSArray *messages) {
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
        [_refreshControl endRefreshing];
        [self reloadViewAll];
        
    } errorBlock:^(int errorCode, NSString *errorMessage) {
        
    } cancelBlock:^{
        
    }];
}

@end
