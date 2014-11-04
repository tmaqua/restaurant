//
//  DialogUtil.h
//  rockport
//
//  Created by tadasuke tsumura on 2013/10/14.
//  Copyright (c) 2013年 TRIART Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDAsyncURLConnection.h"

#define MAX_RETRYCOUNT 10


// ========================================
//
//  各種ユーティリティ定数
//
// ========================================

// メッセージID
typedef enum ALERT_MSG_ID : NSUInteger {
    NOT_CONNECT_NETWORK = 0,    // ネットワーク非接続時
    WEAK_CONNECT_NETWORK,       // ネットワーク微弱(タイムアウト発生)時
    FAILED_LOGIN,               // ログインの失敗時
    FAILED_LOGOUT,              // ログアウトの失敗時
    FAILED_WITHDRAWAL,          // 退会の失敗時
    NOT_INPUT_MAILADDRESS,      // メールアドレス未入力時
    NOT_INPUT_PASSWORD,         // パスワード未入力時
    NOT_LOGIN,                  // 非ログイン時
    TWITTER_SETTING_NONE        // Twitterのアカウント設定がない時
    
} ALERT_MSG_ID;



// キャンセルブロック
typedef void (^cancelBlock_arg0)(void);

// ========================================
//
//  各種ユーティリティ関数
//
// ========================================
@interface PDUtils : NSObject

@property (nonatomic) NSDate *date;


/**
 * アラート文字列の取得
 *
 * @param msg_id    表示するメッセージのID
 *
 * @return ( NSString* )    メッセージ
 */
+(NSString *)getAlertMsg:(ALERT_MSG_ID)msg_id;

/**
 * テキスト付きのアラートダイアログを出力する
 *
 * @param msg_id    表示するメッセージのID
 * @param del       アタッチするデリゲート
 */
+(UIAlertView*)alertDialog:(ALERT_MSG_ID)msg_id delegate:(id)del;

/**
 * タイトル,テキスト付きの情報ダイアログを出力する
 *
 * @param title     表示するタイトル
 * @param text      表示するテキスト
 * @param del       アタッチするデリゲート
 */
+(void)infoDialog:(NSString *)title msg:(NSString *)text delegate:(id)del;

/**
 * ネットワークに接続されているか判定する
 *
 * @return ( BOOL ) ネットワークに接続されている -> true
 */
+(BOOL)isConnectNetwork;

/**
 * 指定URLへのブラウザアクセス
 *
 * @param url   送信先URL
 */
+(void)webTo:(NSString *)url;

/** 
 * ファイルのキャッシュ
 */

+(NSString*)cacheData:(NSString*)_url;

@end
