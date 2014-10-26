//
//  Menu.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/15.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject{
    NSInteger id;
    NSString *title;
    NSString *type;
    NSInteger price;
    BOOL isSoldout;
    BOOL isSelect;
}

@property (nonatomic) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic) NSInteger price;
@property (nonatomic) BOOL isSoldout;
@property (nonatomic) BOOL isSelect;

+ (id)initMenu:(NSInteger)id title:(NSString*)title type:(NSString*)type price:(NSInteger)price isSoldout:(BOOL)isSoldout isSelect:(BOOL)isSelect;

@end
