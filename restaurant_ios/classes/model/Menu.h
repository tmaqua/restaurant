//
//  Menu.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/08/15.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger price;
@property (nonatomic) NSString *image_path;
@property (nonatomic) NSInteger category;
@property (nonatomic) float green;
@property (nonatomic) float red;
@property (nonatomic) float yellow;
@property (nonatomic) BOOL isSoldout;
@property (nonatomic) BOOL isSelect;


- (void)getMenuLog;
- (NSString*)getCategoryName:(NSInteger)category;

@end
