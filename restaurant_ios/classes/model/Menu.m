//
//  Menu.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/15.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "Menu.h"

@implementation Menu

- (NSString*)getCategoryName:(NSInteger)category{
    NSString *categoryName;
    switch (category) {
        case 0:
            categoryName = @"丼・麺";
            break;
        case 1:
            categoryName = @"主菜";
            break;
        case 2:
            categoryName = @"副菜";
            break;
        case 3:
            categoryName = @"その他";
            break;
        default:
            break;
    }
    
    return categoryName;
}

- (void)getMenuLog{
    
    NSLog(@"id: %ld", (long)_id);
    NSLog(@"name: %@", _name);
    NSLog(@"price: %ld", (long)_price);
    NSLog(@"image_path: %@", _image_path);
    NSLog(@"category: %ld", (long)_category);
    NSLog(@"categoryName: %@", [self getCategoryName:_category]);
    NSLog(@"green: %f", _green);
    NSLog(@"red: %f", _red);
    NSLog(@"yellow: %f", _yellow);
    if (_isSoldout) {
        NSLog(@"isSoldout: YES");
    } else {
        NSLog(@"isSelect: NO");
    }
    if (_isSelect) {
        NSLog(@"isSelect: YES");
    } else {
        NSLog(@"isSelect: NO");
    }
    
}

@end

