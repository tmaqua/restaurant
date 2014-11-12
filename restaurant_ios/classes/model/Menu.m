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

//+ (id)initMenu:(NSInteger)id title:(NSString*)title type:(NSString*)type price:(NSInteger)price isSoldout:(BOOL)isSoldout isSelect:(BOOL)isSelect{
//
//    Menu *newMenu = [[self alloc]init];
//    newMenu.id = id;
//    newMenu.title = title;
//    newMenu.type = type;
//    newMenu.price = price;
//    newMenu.isSoldout = isSoldout;
//    newMenu.isSelect = isSelect;
//    
//    return newMenu;
//}

@end

