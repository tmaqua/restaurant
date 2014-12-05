//
//  DetailViewController.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/14.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    switch (_detailMenu.category) {
        case 0:
            _categoryLabel.backgroundColor = [UIColor colorWithRed:0.87 green:0.45 blue:0.40 alpha:1.0];
            break;
        case 1:
            _categoryLabel.backgroundColor = [UIColor colorWithRed:1.00 green:0.56 blue:0.19 alpha:1.0];
            break;
        case 2:
            _categoryLabel.backgroundColor = [UIColor colorWithRed:0.73 green:0.75 blue:0.00 alpha:1.0];
            break;
        case 3:
            _categoryLabel.backgroundColor = [UIColor colorWithRed:0.36 green:0.69 blue:0.56 alpha:1.0];
            break;
        default:
            break;
    }
    
    _redBackground.backgroundColor = [UIColor colorWithRed:0.90 green:0.37 blue:0.16 alpha:1.0];
    _greenBackground.backgroundColor = [UIColor colorWithRed:0.25 green:0.69 blue:0.52 alpha:1.0];
    _yellowBackground.backgroundColor = [UIColor colorWithRed:0.90 green:0.78 blue:0.16 alpha:1.0];
    _saltBackground.backgroundColor = [UIColor colorWithRed:0.43 green:0.49 blue:0.86 alpha:1.0];
    
    _categoryLabel.layer.cornerRadius = 4.0f;
    _redBackground.layer.cornerRadius = 4.0f;
    _greenBackground.layer.cornerRadius = 4.0f;
    _yellowBackground.layer.cornerRadius = 4.0f;
    _saltBackground.layer.cornerRadius = 4.0f;
    
    _redLabel.layer.cornerRadius = 4.0f;
    _greenLabel.layer.cornerRadius = 4.0f;
    _yellowLabel.layer.cornerRadius = 4.0f;
    _saltLabel.layer.cornerRadius = 4.0f;
    
    _titleLabel.text = _detailMenu.name;
    _categoryLabel.text = [_detailMenu getCategoryName:_detailMenu.category];
    _priceLabel.text = [@"￥" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_detailMenu.price]];
    _redLabel.text = [NSString stringWithFormat:@"%.2f", _detailMenu.red];
    _greenLabel.text = [NSString stringWithFormat:@"%.2f", _detailMenu.green];
    _yellowLabel.text = [NSString stringWithFormat:@"%.2f", _detailMenu.yellow];
    
    _caloryLabel.text = [[NSString stringWithFormat:@"%0.2f", _detailMenu.calory/1000] stringByAppendingString:@"Kcal"];
    _saltLabel.text = [[NSString stringWithFormat:@"%.1f", _detailMenu.salt]stringByAppendingString:@"g"];
    
    if ([_detailMenu.image_path  isEqual: @""]) {
        _foodImageView.image = [UIImage imageNamed:@"noimage.jpg"];
    } else {
        NSURL *url = [NSURL URLWithString:_detailMenu.image_path];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                _foodImageView.image = [self resizeImage:downloadedImage];
            });
        }];
        [getImageTask resume];
    }
    
}

- (UIImage*)resizeImage:(UIImage*)srcImage{
    int width = srcImage.size.width;
    int height = srcImage.size.width;
    
    float scale = width/height;
    CGSize resizedSize = CGSizeMake(width, height * scale);
    
//    if (width > height) {
//        resizedSize = CGSizeMake(width, width);
//    } else {
//        resizedSize = CGSizeMake(height, height);
//    }
    UIGraphicsBeginImageContext(resizedSize);
    [srcImage drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
