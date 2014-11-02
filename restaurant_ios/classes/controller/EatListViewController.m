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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    
    _weekSelectNum = 0;
    _selectedImage = [UIImage imageNamed:@"selected.png"];
    _nonselectImage = [UIImage imageNamed:@"nonselect.png"];
    
    [_listDayButton setBackgroundImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    [_listDayButton addTarget:self action:@selector(ListButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_listWeekButton setBackgroundImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    [_listWeekButton addTarget:self action:@selector(ListButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    _dateUnderBar1.backgroundColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    _dateUnderBar2.backgroundColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    _todayPrice.textColor = [UIColor whiteColor];
    _weekPrice.textColor = [UIColor whiteColor];
    
    [self initButton];
    
    [self generateImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ListButtonTap:(UIButton*)button{
    NSInteger eventType = button.tag;
    switch (eventType) {
        case 10: // serch 1day
            _eatlists = @[@"day"];
            break;
        case 20: // serch 1week
            _eatlists = @[@"week"];
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
    
}

-(void)initButton {
    // あとでbuttonクラス作ってここらへんをまとめとこう
    [_weekButton0 addTarget:self
                     action:@selector(buttonDidTap:)
           forControlEvents:UIControlEventTouchUpInside];
    
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
    
    for (int i=0; i<3; i++) {
        UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
        imageView.frame = CGRectMake(20+80*i, 155, 60, 60);
        imageView.tag = i+1;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
    }
    
    for (int i=0; i<3; i++) {
        UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
        imageView.frame = CGRectMake(20+80*i, 275, 60, 60);
        imageView.tag = i+4;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
//    NSLog(@"%ld", (long)touch.view.tag);
    if(touch.view.tag >= 1 && touch.view.tag < 10){
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
}
@end
