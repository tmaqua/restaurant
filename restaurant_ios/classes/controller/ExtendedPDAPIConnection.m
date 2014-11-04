//
//  NSObject+ExtendedPDAPIConnection.m
//  restaurant_ios
//
//  Created by 村上智紀 on 2014/11/04.
//  Copyright (c) 2014年 pad. All rights reserved.
//

#import "ExtendedPDAPIConnection.h"

@implementation ExtendedPDAPIConnection

+(void)getMessages:(CGFloat)sec completeBlock:(getMessagesCompleteBlock)cp_block errorBlock:(errorBlock)e_block cancelBlock:(cancelBlock)cc_block{
    
    NSMutableURLRequest *req = [ExtendedPDAPIConnection createGetRequest:API_MESSEAGE_GET];
    [ExtendedPDAPIConnection asyncConnect:req timeoutSec:sec
                  completeBlock:^(PDAsyncURLConnection *conn, NSData *data){
                      if([[conn response] statusCode] == 200){
                          NSDictionary *messagesDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                          
                          NSMutableArray *messageArray = [NSMutableArray array];
                          
                          MenuList *menuModel = MenuList.new;
                          [menuModel setMessageInfo:messagesDict];
                          [messageArray addObject:menuModel];
                          
                          if(cp_block){
                              cp_block(messageArray);
                          }
                      }else if(e_block)
                          e_block(-1,@"");
                  }
                     errorBlock:^(id conn, NSError *error){
                         if(e_block){
                             e_block(-1,@"");
                         }
                     }
                    cancelBlock:^(void){
                        if(cc_block){
                            cc_block();
                        }
                    }
     ];
    
    
}

@end
