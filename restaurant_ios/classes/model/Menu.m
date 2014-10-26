//
//  Menu.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/15.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "Menu.h"

@implementation Menu
@synthesize id;
@synthesize title;
@synthesize type;
@synthesize price;
@synthesize isSoldout;
@synthesize isSelect;

+ (id)initMenu:(NSInteger)id title:(NSString*)title type:(NSString*)type price:(NSInteger)price isSoldout:(BOOL)isSoldout isSelect:(BOOL)isSelect{

    Menu *newMenu = [[self alloc]init];
    newMenu.id = id;
    newMenu.title = title;
    newMenu.type = type;
    newMenu.price = price;
    newMenu.isSoldout = isSoldout;
    newMenu.isSelect = isSelect;
    
    return newMenu;
}

@end

