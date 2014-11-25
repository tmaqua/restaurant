//
//  EatListViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "EatListViewController.h"

@interface EatListViewController ()

@end

@implementation EatListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navbar change color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _weekSelectNum = 0;
    _selectedImage = [UIImage imageNamed:@"selected.png"];
    _nonselectImage = [UIImage imageNamed:@"nonselect.png"];
    
    [_listDayButton setBackgroundImage:[UIImage imageNamed:@"listButton.png"] forState:UIControlStateNormal];
    [_listDayButton addTarget:self action:@selector(ListButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_listWeekButton setBackgroundImage:[UIImage imageNamed:@"listButton.png"] forState:UIControlStateNormal];
    [_listWeekButton addTarget:self action:@selector(ListButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    _dateUnderBar1.backgroundColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    _dateUnderBar2.backgroundColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    _todayPrice.textColor = [UIColor whiteColor];
    _weekPrice.textColor = [UIColor whiteColor];
    
    [self initButton];
    
    [_eatListsFromDay removeAllObjects];
    [_eatListsFromWeek removeAllObjects];
    
    NSDate *today = [self getDateSZero:[NSDate date]];
    int unixtime = [today timeIntervalSince1970];
    
    NSLog(@"\n\n******UNIXTIME******%d", unixtime);
    
    [self getEatListsFromDay:[NSNumber numberWithInt:unixtime]];
    
    NSDate *weekStart = _selectedWeeks[0];
    NSDate *weekEnd = _selectedWeeks[6];
    int weekStartNum = [weekStart timeIntervalSince1970];
    int weekEndNum = [weekEnd timeIntervalSince1970];
    
    [self getEatListsFromWeek:[NSNumber numberWithInt:weekStartNum] weekEnd:[NSNumber numberWithInt:weekEndNum]];
    
    
    [self generateImageView];
    [self calcSumPrice];
    
}

- (void)calcSumPrice{
    int daySumPrice = 0;
    int weekSumPrice = 0;
    for (Food *food in _eatListsFromDay) {
        daySumPrice += [food.price intValue];
    }
    for (Food *food in _eatListsFromWeek) {
        weekSumPrice += [food.price intValue];
    }
    NSLog(@"%d", daySumPrice);
    NSLog(@"%d", weekSumPrice);
    NSString *str1 = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%d", daySumPrice]];
    NSString *str2 = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%d", weekSumPrice]];
    
    _todayPrice.text = str1;
    _weekPrice.text = str2;
}

- (void)getEatListsFromDay:(NSNumber*)day{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *eatLists = [self findDataInDay:day];

    for (int i=0; i < [eatLists count]; i++) {
        EatList *foods = eatLists[i];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"food_id" ascending:YES];
        NSArray *sortDescriptor = [NSArray arrayWithObject:sort];
        NSArray *food = [[foods.food sortedArrayUsingDescriptors:sortDescriptor]mutableCopy];

        [tempArray addObjectsFromArray:food];
    }
    
    _eatListsFromDay = tempArray;
    
}

- (void)getEatListsFromWeek:(NSNumber*)weekStart weekEnd:(NSNumber*)weekEnd{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSArray *eatLists = [self findDataInWeek:weekStart weekEnd:weekEnd];
    
    for (int i=0; i < [eatLists count]; i++) {
        EatList *foods = eatLists[i];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"food_id" ascending:YES];
        NSArray *sortDescriptor = [NSArray arrayWithObject:sort];
        NSArray *food = [[foods.food sortedArrayUsingDescriptors:sortDescriptor]mutableCopy];
        
        [tempArray addObjectsFromArray:food];
    }
    
    _eatListsFromWeek = tempArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonDidTap:(UIButton *)button
{
    //タグを格納
    NSInteger eventType = button.tag-1;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];

    switch (eventType) {
        case 0:
            [_weekButton0 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            break;
        case 1:
            [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            break;
        case 2:
            [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            break;
        case 3:
            [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            break;
        case 4:
            [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            break;
        case 5:
            [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            break;
        case 6:
            [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
            [_weekButton6 setBackgroundImage:_selectedImage forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    _todayDate.text = [dateFormatter stringFromDate:_selectedWeeks[eventType]];
    
    [self getSelectedMenuData];
    [self generateImageView];
    [self calcSumPrice];
    
}

-(void)initButton {
    // あとでbuttonクラス作ってここらへんをまとめとこう
    
    [_weekButton0 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    [_weekButton1 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    [_weekButton2 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    [_weekButton3 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    [_weekButton4 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    [_weekButton5 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    [_weekButton6 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self calcDate];
}

- (void)calcDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *showDayFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [showDayFormatter setLocale:[NSLocale currentLocale]];
    NSMutableArray *weekDay = [self getThisWeekDays];
    
    _selectedWeeks = [weekDay mutableCopy];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    _todayDate.text = [dateFormatter stringFromDate:date];
    _todayDate.textColor = [UIColor whiteColor];
    NSString *todayStr = [dateFormatter stringFromDate:date];
    
    NSString *str1 = [dateFormatter stringFromDate:weekDay[0]];
    [dateFormatter setDateFormat:@"MM/dd"];
    NSString *str2 = [dateFormatter stringFromDate:weekDay[6]];
    NSString *str = [NSString stringWithFormat:@"%@〜%@", str1, str2];
    
    _weekLabel7.text = str;
    _weekLabel7.textColor = [UIColor whiteColor];

    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    [showDayFormatter setDateFormat:@"dd"];
    [_weekButton0 setTitle:[showDayFormatter stringFromDate:weekDay[0]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[0]]]) {
        [_weekButton0.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton0.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton0 setBackgroundColor:[UIColor whiteColor]];
    
    [_weekButton1 setTitle:[showDayFormatter stringFromDate:weekDay[1]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[1]]]) {
        [_weekButton1.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton1.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton1 setBackgroundColor:[UIColor whiteColor]];
    
    [_weekButton2 setTitle:[showDayFormatter stringFromDate:weekDay[2]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[2]]]) {
        [_weekButton2.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton2.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton2 setBackgroundColor:[UIColor whiteColor]];
    
    [_weekButton3 setTitle:[showDayFormatter stringFromDate:weekDay[3]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[3]]]) {
        [_weekButton3.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton3.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton3 setBackgroundColor:[UIColor whiteColor]];
    
    [_weekButton4 setTitle:[showDayFormatter stringFromDate:weekDay[4]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[4]]]) {
        [_weekButton4.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton4.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton4 setBackgroundColor:[UIColor whiteColor]];
    
    [_weekButton5 setTitle:[showDayFormatter stringFromDate:weekDay[5]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[5]]]) {
        [_weekButton5.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton5.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton5 setBackgroundColor:[UIColor whiteColor]];
    
    [_weekButton6 setTitle:[showDayFormatter stringFromDate:weekDay[6]] forState:UIControlStateNormal];
    if ([todayStr isEqualToString:[dateFormatter stringFromDate:weekDay[6]]]) {
        [_weekButton6.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton6.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [_weekButton6 setBackgroundColor:[UIColor whiteColor]];
    
}

- (NSMutableArray*)getThisWeekDays {
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)fromDate:today];
    NSDate *tempDate = [today initWithTimeInterval:-1*(comps.weekday-1+_weekSelectNum)*24*60*60 sinceDate:today];
    NSMutableArray *weeks = [NSMutableArray array];

    [weeks addObject:tempDate];
    for (int i = 1; i < 7; i++) {
        [weeks addObject:[tempDate initWithTimeInterval:(i)*24*60*60 sinceDate:tempDate]];
    }
    return weeks;
}


- (void)generateImageView {
    int dayImageNum;
    int weekImageNum;
    
    for (UIView *view in self.view.subviews) {
        if (view.tag >= 1000 && view.tag <= 1005) {
            [view removeFromSuperview];
        }
    }
    
    if ([_eatListsFromDay count] >= 3) {
        dayImageNum = 3;
    }else{
        dayImageNum = (int)[_eatListsFromDay count];
    }
    
    if ([_eatListsFromWeek count] >= 3) {
        weekImageNum = 3;
    }else{
        weekImageNum = (int)[_eatListsFromWeek count];
    }
    
    
    for (int i=0; i<dayImageNum; i++) {
        Food *food = _eatListsFromDay[i];
        if ([food.image_path  isEqual:@""]) {
            UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noimage.jpg"]];
            imageView.frame = CGRectMake(20+80*i, 155, 60, 60);
            imageView.tag = i+1000;
            imageView.userInteractionEnabled = YES;
            [self.view addSubview:imageView];
        } else {
            NSURL *url = [NSURL URLWithString:food.image_path];
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
            
            NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageView *imageView =[[UIImageView alloc] initWithImage:downloadedImage];
                    imageView.frame = CGRectMake(20+80*i, 155, 60, 60);
                    imageView.tag = i+1000;
                    imageView.userInteractionEnabled = YES;
                    [self.view addSubview:imageView];
                });
            }];
            [getImageTask resume];
        }
    }
    
    for (int i=0; i<weekImageNum; i++) {
        Food *food = _eatListsFromWeek[i];
        if ([food.image_path  isEqual: @""]) {
            UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noimage.jpg"]];
            imageView.frame = CGRectMake(20+80*i, 275, 60, 60);
            imageView.tag = i+1003;
            imageView.userInteractionEnabled = YES;
            [self.view addSubview:imageView];
        } else {
            NSURL *url = [NSURL URLWithString:food.image_path];
            
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
            
            NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageView *imageView =[[UIImageView alloc] initWithImage:downloadedImage];
                    imageView.frame = CGRectMake(20+80*i, 275, 60, 60);
                    imageView.tag = i+1003;
                    imageView.userInteractionEnabled = YES;
                    [self.view addSubview:imageView];
                });
            }];
            [getImageTask resume];
        }
    }

}

- (void)ListButtonTap:(UIButton*)button{
    NSInteger eventType = button.tag;
    
    [self getSelectedMenuData];
    
    switch (eventType) {
        case 10: // serch 1day
            _eatlists = _eatListsFromDay;
            break;
        case 20: // serch 1week
            _eatlists = _eatListsFromWeek;
            break;
        default:
            break;
    }
    [self performSegueWithIdentifier:@"toEatenListSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toEatenListSegue"]) {
        EatenFoodViewController *vc = (EatenFoodViewController*)[segue destinationViewController];
        vc.eatenFoods = _eatlists;
    }
    if ([[segue identifier] isEqualToString:@"toDetailSegue"]) {
        DetailViewController *vc = (DetailViewController*)[segue destinationViewController];
        vc.detailMenu = _toDetailMenu;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    
    if(touch.view.tag >= 1000 && touch.view.tag <= 1005){
        switch (touch.view.tag) {
            case 1000:
                _toDetailMenu = [self transFoodModelToMenuModel:_eatListsFromDay[0]];
                break;
            case 1001:
                _toDetailMenu = [self transFoodModelToMenuModel:_eatListsFromDay[1]];
                break;
            case 1002:
                _toDetailMenu = [self transFoodModelToMenuModel:_eatListsFromDay[2]];
                break;
            case 1003:
                _toDetailMenu = [self transFoodModelToMenuModel:_eatListsFromWeek[0]];
                break;
            case 1004:
                _toDetailMenu = [self transFoodModelToMenuModel:_eatListsFromWeek[1]];
                break;
            case 1005:
                _toDetailMenu = [self transFoodModelToMenuModel:_eatListsFromWeek[2]];
                break;
            default:
                break;
        }
        [self performSegueWithIdentifier:@"toDetailSegue" sender:self];
    }
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

- (IBAction)backButton:(id)sender {
    _weekSelectNum += 7.0;
    [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [self calcDate];
    [self getSelectedMenuData];
    [self generateImageView];
    [self calcSumPrice];
}

- (IBAction)newxtButton:(id)sender {
    _weekSelectNum -= 7.0;
    [_weekButton0 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton1 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton2 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton3 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton4 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton5 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [_weekButton6 setBackgroundImage:_nonselectImage forState:UIControlStateNormal];
    [self calcDate];
    [self getSelectedMenuData];
    [self generateImageView];
    [self calcSumPrice];
}


// ! test func
- (IBAction)testAllDelete:(id)sender {
    // CoreData All Delete
    [EatList MR_truncateAll];
    [Food MR_truncateAll];
}

- (NSArray*)findDataInDay:(NSNumber*)day{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ate_at == %@", day];
    return [EatList MR_findAllWithPredicate:predicate];
}

- (NSArray*)findDataInWeek:(NSNumber*)weekStart weekEnd:(NSNumber*)weekEnd{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ate_at >= %@) AND (ate_at <= %@)",weekStart, weekEnd];
    NSArray *eatlists = [EatList MR_findAllWithPredicate:predicate];
    return eatlists;
}

- (NSDate*)getDateSZero:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:flags fromDate:date];
    
    return [calendar dateFromComponents:components];
}

- (void)getSelectedMenuData{
    NSDateFormatter *dateFormatterZero = [[NSDateFormatter alloc] init];
    [dateFormatterZero setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    [dateFormatterZero setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    NSString *todayStr = [_todayDate.text stringByAppendingString:@" 00:00:00"];
    NSDate* date = [dateFormatterZero dateFromString:todayStr];
    int unixtime = [date timeIntervalSince1970];
    
    NSDate *weekStart = _selectedWeeks[0];
    NSDate *weekEnd = _selectedWeeks[6];
    int weekStartNum = [weekStart timeIntervalSince1970];
    int weekEndNum = [weekEnd timeIntervalSince1970];
    [self getEatListsFromDay:[NSNumber numberWithInt:unixtime]];
    [self getEatListsFromWeek:[NSNumber numberWithInt:weekStartNum] weekEnd:[NSNumber numberWithInt:weekEndNum]];
}

- (Menu*)transFoodModelToMenuModel:(Food*)food{
    Menu *menu = Menu.new;
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
    
    return menu;
}

@end
