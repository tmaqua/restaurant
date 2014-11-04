//
//  MyAsyncURLConnection.h
//  rockport
//
//  Created by tadasuke tsumura on 2013/10/14.
//  Copyright (c) 2013年 TRIART Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^asyncCompleteBlock)(id connection, NSData *data);
typedef void (^asyncProgressBlock)(id connection, NSDictionary *dict);
typedef void (^asyncErrorBlock)(id connection, NSError *error);
typedef void (^asyncCancelBlock)(void);


@interface PDAsyncURLConnection : NSObject {}

@property (nonatomic, retain)   NSMutableData     *data;
@property (nonatomic, copy)     asyncCompleteBlock   completeBlock;
@property (nonatomic, copy)     asyncProgressBlock   progressBlock;
@property (nonatomic, copy)     asyncErrorBlock      errorBlock;
@property (nonatomic, retain)   NSHTTPURLResponse *response;
@property (nonatomic, retain)   NSURLRequest      *request;
@property (nonatomic, retain)   NSURLConnection   *connection;
@property (nonatomic)           CGFloat           timeoutSec;

/**
 * リクエストの初期化
 */
-(id)initWithRequest:(NSURLRequest *)req
          timeoutSec:(CGFloat)sec
       completeBlock:(asyncCompleteBlock)c_block
       progressBlock:(asyncProgressBlock)p_block
          errorBlock:(asyncErrorBlock)e_block;

/**
 * リクエストの実行
 */
-(void)performRequest;

/**
 * リクエストのキャンセル
 */
-(void)cancel;

/**
 * 処理の完了を待つ
 */
-(void)join;

@end
