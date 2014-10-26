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
    // Do any additional setup after loading the view.
    _weekSelectNum = 0;
    
    [_listButton setBackgroundImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    _dateUnderBar1.backgroundColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    _dateUnderBar2.backgroundColor = [UIColor colorWithRed:1.00 green:0.66 blue:0.27 alpha:1.0];
    _todayPrice.textColor = [UIColor whiteColor];
    _weekPrice.textColor = [UIColor whiteColor];
    
    // あとでuibuttonクラス作ってここらへんをまとめとこう
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
    
    [self generateImageView];
    
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
//    button.backgroundColor = [UIColor blueColor];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];

    _todayDate.text = [dateFormatter stringFromDate:_selectedWeeks[eventType]];
    
}

- (void)calcDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSMutableArray *weekDay = [self getThisWeekDays];
    
    _selectedWeeks = [weekDay mutableCopy];
    
    NSInteger todayweek = [weekDay[7] integerValue];

    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    _todayDate.text = [dateFormatter stringFromDate:date];
    _todayDate.textColor = [UIColor whiteColor];
    
    NSString *str1 = [dateFormatter stringFromDate:weekDay[0]];
    [dateFormatter setDateFormat:@"MM/dd"];
    NSString *str2 = [dateFormatter stringFromDate:weekDay[6]];
    NSString *str = [NSString stringWithFormat:@"%@〜%@", str1, str2];
    
    _weekLabel7.text = str;
    _weekLabel7.textColor = [UIColor whiteColor];
    
    [dateFormatter setDateFormat:@"dd"];
    [_weekButton0 setTitle:[dateFormatter stringFromDate:weekDay[0]] forState:UIControlStateNormal];
    if (todayweek == 0) {
        [_weekButton0.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton0.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    [_weekButton1 setTitle:[dateFormatter stringFromDate:weekDay[1]] forState:UIControlStateNormal];
    if (todayweek == 1) {
        [_weekButton1.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton1.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    [_weekButton2 setTitle:[dateFormatter stringFromDate:weekDay[2]] forState:UIControlStateNormal];
    if (todayweek == 2) {
        [_weekButton2.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton2.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    [_weekButton3 setTitle:[dateFormatter stringFromDate:weekDay[3]] forState:UIControlStateNormal];
    if (todayweek == 3) {
        [_weekButton3.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton3.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    [_weekButton4 setTitle:[dateFormatter stringFromDate:weekDay[4]] forState:UIControlStateNormal];
    if (todayweek == 4) {
        [_weekButton4.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton4.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    [_weekButton5 setTitle:[dateFormatter stringFromDate:weekDay[5]] forState:UIControlStateNormal];
    if (todayweek == 5) {
        [_weekButton5.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton5.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    [_weekButton6 setTitle:[dateFormatter stringFromDate:weekDay[6]] forState:UIControlStateNormal];
    if (todayweek == 6) {
        [_weekButton6.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    } else {
        [_weekButton6.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
}

- (NSMutableArray*)getThisWeekDays {
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)fromDate:today];
    
    
    NSDate *tempDate = [today initWithTimeInterval:-1*(comps.weekday-1+_weekSelectNum)*24*60*60 sinceDate:today];
    NSMutableArray *weeks = [NSMutableArray array];
    NSInteger todayWeek = comps.weekday-1;

    [weeks addObject:tempDate];
    for (int i = 1; i < 7; i++) {
        [weeks addObject:[tempDate initWithTimeInterval:(i)*24*60*60 sinceDate:tempDate]];
    }
    
    [weeks addObject:[NSNumber numberWithInteger:todayWeek]];
    
//    NSLog(@"%@", weeks);
    
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
    if(touch.view.tag >= 1){
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
    [self calcDate];
}

- (IBAction)newxtButton:(id)sender {
    _weekSelectNum -= 7.0;
    [self calcDate];
}
@end
