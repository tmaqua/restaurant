//
//  APIConnection.h
//  festival
//
//  Created by 岡室 庄悟 on 2014/05/18.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDAsyncURLConnection.h"


@interface PDAPIConnection : NSObject

/**
 * 送信リクエストのベースオブジェクトの生成
 *
 * @param url   送信先URL
 *
 * @return ( NSMutableURLRequest* ) 結果のオブジェクト
 */
+(NSMutableURLRequest *)createRequestBase:(NSString *)url;



/**
 * GETリクエスト用オブジェクトの生成
 *
 * @param url   送信先URL
 *
 * @return ( NSMutableURLRequest* ) 結果のオブジェクト
 */
+(NSMutableURLRequest *)createGetRequest:(NSString *)url;


/**
 * POSTリクエスト用オブジェクトの生成
 *
 * @param url       送信先URL
 * @param data      POSTデータ
 * @param data_len  POSTデータサイズ
 *
 * @return ( NSMutableURLRequest* ) 結果のオブジェクト
 */
+(NSMutableURLRequest *)createPostRequest:(NSString *)url data:(NSData *)data dataLen:(int)data_len;

/**
 * 通信処理のベース実装
 */
+(void)innerConnect:(NSURLRequest *)req timeoutSec:(CGFloat)sec completeBlock:(asyncCompleteBlock)cp_block errorBlock:(asyncErrorBlock)e_block cancelBlock:(asyncCancelBlock)cc_block sync:(BOOL)sync;


/**
 * 非同期通信処理
 *
 * アプリがバックグラウンドへ移行した場合は,処理を中断する
 *
 * @param req       リクエスト
 * @param sec       タイムアウト時間(sec)
 * @param cp_block  処理完了時ブロック
 * @param e_block   通信エラー時ブロック
 * @param cc_block  処理中断時ブロック ( バックグラウンド移行時 )
 */
+(void)asyncConnect:(NSURLRequest *)req timeoutSec:(CGFloat)sec completeBlock:(asyncCompleteBlock)cp_block errorBlock:(asyncErrorBlock)e_block cancelBlock:(asyncCancelBlock)cc_block;

@end
