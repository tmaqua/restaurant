//
//  APIConnection.m
//  festival
//
//  Created by 岡室 庄悟 on 2014/05/18.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "PDAPIConnection.h"

@implementation PDAPIConnection

/**
 * 送信リクエストのベースオブジェクトの生成
 */
+(NSMutableURLRequest *)createRequestBase:(NSString *)url_str {
    
    // ---------------------------------------------------------
    //  1. リクエストオブジェクトの生成
    // ---------------------------------------------------------
    NSURL *url = [NSURL URLWithString:url_str];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // ---------------------------------------------------------
    //  2. 共通パラメータの設定
    // ---------------------------------------------------------
    // [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    UIDevice *device = [[UIDevice alloc]init];
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@/App/%@",[device model],[device systemVersion],[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [req setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [req setValue:[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"version"];
    
    return req;
}

/**
 * GETリクエスト用オブジェクトの生成
 */
+(NSMutableURLRequest *)createGetRequest:(NSString *)url_str {
    NSMutableURLRequest *req = [PDAPIConnection createRequestBase:url_str];
    
    [req setHTTPMethod:@"GET"];
    
    return req;
}

/**
 * POSTリクエスト用オブジェクトの生成
 */
+(NSMutableURLRequest *)createPostRequest:(NSString *)url_str data:(NSData *)data dataLen:(int)data_len {
    NSMutableURLRequest *req = [PDAPIConnection createRequestBase:url_str];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:[NSString stringWithFormat:@"%d", data_len] forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:data];
    
    return req;
}

/**
 * 通信処理のベース実装
 */
+(void)innerConnect:(NSURLRequest *)req timeoutSec:(CGFloat)sec completeBlock:(asyncCompleteBlock)cp_block errorBlock:(asyncErrorBlock)e_block cancelBlock:(asyncCancelBlock)cc_block sync:(BOOL)sync {
    
    PDAsyncURLConnection *conn = nil;
    
    // 1. バックグラウンド移行の通知要求
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    __block id observer = [nc addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:
                           ^(NSNotification *notification)
                           {
                               NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
                               [nc removeObserver:observer];
                               observer = nil;
                               
                               // 通信をキャンセルする
                               [conn cancel];
                               
                               // キャンセル時処理の実行
                               if ( cc_block ) cc_block();
                           } ];
    
    // 2. 非同期通信オブジェクトの生成
    conn = [[PDAsyncURLConnection alloc] initWithRequest:req timeoutSec:sec
                                           completeBlock:^(PDAsyncURLConnection *conn, NSData* data)
            {
                [nc removeObserver:observer];
                observer = nil;
                if ( cp_block ) cp_block( conn, data );
            }
                                           progressBlock:nil
                                              errorBlock:^(id conn, NSError* error) {
                                                  [nc removeObserver:observer];
                                                  observer = nil;
                                                  
                                                  if ( e_block ) e_block( conn, error );
                                              } ];
    
    // 3. 通信の開始
    [conn performRequest];
    
    // 4. 同期通信を要求された場合 -> 待ち状態に入る
    if ( sync ) [conn join];
}

/**
 * 非同期通信処理
 */
+(void)asyncConnect:(NSURLRequest *)req timeoutSec:(CGFloat)sec completeBlock:(asyncCompleteBlock)cp_block errorBlock:(asyncErrorBlock)e_block cancelBlock:(asyncCancelBlock)cc_block {
    
    [PDAPIConnection innerConnect:req timeoutSec:sec completeBlock:cp_block errorBlock:e_block cancelBlock:cc_block sync:NO];
}


@end
