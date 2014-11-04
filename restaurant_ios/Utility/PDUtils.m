//
//  DialogUtil.m
//  rockport
//
//  Created by tadasuke tsumura on 2013/10/14.
//  Copyright (c) 2013年 TRIART Inc. All rights reserved.
//

#import "PDUtils.h"
#import "Reachability.h"


static NSString* const ALERTMSG[] =
{
    @"ネットワークに接続されていません",
    @"通信状況の良い場所で再度アクセスしてください",
    @"ログインに失敗しました",
    @"ログアウトに失敗しました",
    @"退会に失敗しました",
    @"メールアドレスが入力されていません",
    @"パスワードが入力されていません",
    @"ログインしていません",
    @"Twitterのアカウント設定を確認してください"
};

@interface PDUtils()


@end

@implementation PDUtils

/**
 * アラート文字列の取得
 */
+(NSString *)getAlertMsg:(ALERT_MSG_ID)msg_id {
    return ALERTMSG[ msg_id ];
}

/**
 * テキスト付きのアラートダイアログを出力する
 */
+(UIAlertView*)alertDialog:(ALERT_MSG_ID)msg_id delegate:(id)del {

    // アラートビューの生成
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                              message:ALERTMSG[ msg_id ]
                                              delegate:del
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [alert show];
 
    return alert;
}

/**
 * タイトル,テキスト付きの情報ダイアログを出力する
 */
+(void)infoDialog:(NSString *)title msg:(NSString *)text delegate:(id)del {
    
    // アラートビューの生成
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:text
                                                   delegate:del
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];

}

/**
 * ネットワークに接続されているか判定する
 *
 * @return ( BOOL ) ネットワークに接続されている -> true
 */
+(BOOL)isConnectNetwork {
    
    // ネットーワーク状況の判定と対応
    Reachability *cur_reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus net_status = [cur_reach currentReachabilityStatus];
    return ( net_status!=NotReachable );
}




/**
 * 指定URLへのブラウザアクセス
 */
+(void)webTo:(NSString *)_url {
    NSURL *url = [NSURL URLWithString:_url];
    [[UIApplication sharedApplication] openURL:url];
}

/**
 *  ファイルのキャッシュ
 */

+(NSString*)cacheData:(NSString*)_url{
    if(![_url length]){
        return nil;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSTimeInterval timestamp_now = [[NSDate date]timeIntervalSince1970];
    NSString *cachePath = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"%f",timestamp_now]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[userDefaults objectForKey:@"cacheData"]];
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:_url]];
    
    
    
    if(dict1){
        
        
        BOOL fileExists = NO;
        
        if([dict1 objectForKey:@"filePath"])
            fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[dict1 objectForKey:@"filePath"]];
        
        
        NSTimeInterval timestamp_past = [[dict1 objectForKey:@"datetime"]doubleValue];
        
        if(!fileExists ||  timestamp_now - timestamp_past > 3600 * 24 * 2){//キャッシュのデータが2日前の場合
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_url]];
            [fm createFileAtPath:cachePath contents:data attributes:nil];
            
            
            [dict1 setObject:[NSString stringWithFormat:@"%lf",timestamp_now] forKey:@"datetime"];
            [dict1 setObject:cachePath forKey:@"filePath"];
            [dict setObject:dict1 forKey:_url];
            [userDefaults setValue:dict forKey:@"cacheData"];
            
        }else{
            cachePath = [dict1 objectForKey:@"filePath"];
        }
        
        
    }else{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_url]];
        [fm createFileAtPath:cachePath contents:data attributes:nil];
        
        
        dict1 = [[NSMutableDictionary alloc]init];
        [dict1 setObject:[NSString stringWithFormat:@"%f",timestamp_now] forKey:@"datetime"];
        [dict1 setObject:cachePath forKey:@"filePath"];
        [dict setObject:dict1 forKey:_url];
        
        [userDefaults setValue:dict forKey:@"cacheData"];
        
        
    }
    return cachePath;
}




@end
