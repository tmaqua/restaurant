//
//  MyAsyncURLConnection.m
//  rockport
//
//  Created by tadasuke tsumura on 2013/10/14.
//  Copyright (c) 2013年 TRIART Inc. All rights reserved.
//

#import "PDAsyncURLConnection.h"

@interface PDAsyncURLConnection()

@property (nonatomic, readwrite) BOOL connectionComplete;   // 通信の完了状態
@property (nonatomic, readwrite) BOOL synchronousComplete;  // 同期通信の完了状態

@end

@implementation PDAsyncURLConnection

@synthesize data;
@synthesize completeBlock;
@synthesize progressBlock;
@synthesize errorBlock;
@synthesize response;
@synthesize request;
@synthesize connection;
@synthesize timeoutSec;

/**
 * リクエストの初期化
 */
-(id)initWithRequest:(NSURLRequest *)req
          timeoutSec:(CGFloat)sec
       completeBlock:(asyncCompleteBlock)c_block
       progressBlock:(asyncProgressBlock)p_block
          errorBlock:(asyncErrorBlock)e_block
{
    if ( (self=[super init]) ) {
        self.data = [NSMutableData data];
        
        self.completeBlock = c_block;
        self.progressBlock = p_block;
        self.errorBlock = e_block;
        
        self.request = req;
        self.timeoutSec = sec;
    }
    return self;
}

/**
 * メモリの解放
 */
-(void)dealloc {
    self.completeBlock = nil;
    self.progressBlock = nil;
    self.errorBlock = nil;
    
    self.data = nil;
    self.response = nil;
    self.connection = nil;
    self.request = nil;
}

/**
 * リクエストの実行
 */
-(void)performRequest {
    
    // リクエスト実行のデフォルトは非同期通信
    self.connectionComplete = NO;
    self.synchronousComplete = YES;
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self performSelector:@selector(timeout) withObject:nil afterDelay:timeoutSec];
}

/**
 * リクエストのキャンセル
 */
-(void)cancel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
    [connection cancel];
}

/**
 * 処理の完了を待つ
 */
-(void)join {
    
    @try {
        
        // 既に通信が完了状態 -> 終了
        if ( self.connectionComplete ) return;

        self.synchronousComplete = NO;
        
        // 通信の完了を待つ
        NSRunLoop *rl = [NSRunLoop currentRunLoop];
        while ( !self.synchronousComplete && [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
        
    }
    @catch (NSException *e) {}
    @finally {}
}

/**
 * タイムアウト処理
 */
-(void)timeout {
    [self cancel];
    [self connection:connection didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"", NSLocalizedDescriptionKey, nil]]];
}

#pragma mark - NSURLConnection delegate method

/**
 * 自己SSL証明書のエラー無視
 */
- (BOOL) connection:(NSURLConnection *)connection
canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}



-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)res {
    NSHTTPURLResponse *hres = ( NSHTTPURLResponse * )res;
    self.response = hres;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    [data appendData:d];
    if ( progressBlock ) progressBlock( self, [NSDictionary dictionaryWithObjectsAndKeys:data,@"data", nil]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
    if ( completeBlock ) completeBlock( self, data );
    
    self.connectionComplete = TRUE;
    self.synchronousComplete = TRUE;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeout) object:nil];
    if ( errorBlock ) errorBlock( self, error );
    
    self.connectionComplete = TRUE;
    self.synchronousComplete = TRUE;
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if ( progressBlock ) {
        progressBlock( self,
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithInt:bytesWritten], @"bytesWritten",
                        [NSNumber numberWithInt:totalBytesWritten], @"totalBytesWritten",
                        [NSNumber numberWithInt:totalBytesExpectedToWrite], @"totalBytesExpectedToWrite",
                        nil] );
    }
}

@end
