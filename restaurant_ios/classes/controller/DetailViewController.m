//
//  DetailViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
    
    _titleLabel.text = _detailMenu.name;
    _categoryLabel.text = [_detailMenu getCategoryName:_detailMenu.category];
    _priceLabel.text = [NSString stringWithFormat:@"%ld", (long)_detailMenu.price];
    _redLabel.text = [NSString stringWithFormat:@"%f", _detailMenu.red];
    _greenLabel.text = [NSString stringWithFormat:@"%f", _detailMenu.green];
    _yellowLabel.text = [NSString stringWithFormat:@"%f", _detailMenu.yellow];
    if ([_detailMenu.image_path  isEqual: @""]) {
        _foodImageView.image = [UIImage imageNamed:@"noimage.jpg"];
    } else {
        NSURL *url = [NSURL URLWithString:_detailMenu.image_path];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                _foodImageView.image = downloadedImage;
            });
        }];
        [getImageTask resume];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
