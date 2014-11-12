//
//  NSObject+MenuList.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/11/04.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "MenuList.h"

@implementation MenuList

- (void)setMessageInfo:(NSDictionary *)dict {
    _menus = [dict objectForKey:@"menus"];
    
//    for (int i =0; i<[_menus count]; i++) {
//        NSLog(@"\n\nName: %@\n\n", _menus[i][@"food"][@"name"]);
//    }
}

@end
