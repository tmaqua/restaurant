//
//  NSObject+ExtendedPDAPIConnection.h
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/11/04.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDAPIConnection.h"
#import "MenuList.h"

#define API_MESSEAGE_GET @"http://restaurant.planningdev.com/api/menu/list.json"
//#define API_MESSEAGE_GET @"http://restaurant.planningdev.com/api/menu"

@interface ExtendedPDAPIConnection: PDAPIConnection

typedef void (^cancelBlock)(void);
typedef void (^errorBlock)(int errorCode,NSString *errorMessage);
typedef void (^getMessagesCompleteBlock)(NSArray *messages);

+(void)getMessages:(CGFloat)sec params:(NSString*)params completeBlock:(getMessagesCompleteBlock)cp_block errorBlock:(errorBlock)e_block cancelBlock:(cancelBlock)cc_block;

@end
