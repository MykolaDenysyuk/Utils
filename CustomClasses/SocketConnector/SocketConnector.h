//
//  SocketConnector.h
//  Utils
//
//  Created by Mykola Denysyuk on 2/19/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>


// Definitions:
//--------------------------------------------------------------------
@class SocketConnector;

typedef NS_OPTIONS(NSInteger, SocketConnectorMode) {
    SocketConnectorRead         = 1<< 1,
    SocketConnectorWrite        = 1<< 2,
    SocketConnectorReadWrite    = SocketConnectorRead|SocketConnectorWrite,
};
typedef void(^SocketConnectorMessageBlock)(id message);
//--------------------------------------------------------------------


/** Simple socket connector class */
@interface SocketConnector : NSObject <NSStreamDelegate>

@property (readonly, nonatomic) NSString * host;
@property (readonly, nonatomic) NSInteger port;
@property (readonly, nonatomic) SocketConnectorMode mode;
/** YES if connection is openned */
@property (readonly, nonatomic, getter=isConnected) BOOL connected;

/** Initiaizes socket with given host name/path and port */
- (instancetype)initWithHost:(NSString *)host andPort:(NSInteger)port mode:(SocketConnectorMode)mode NS_DESIGNATED_INITIALIZER;
/** Initiaizes socket with given host name/path, port and default mode (read-write) */
- (instancetype)initWithHost:(NSString *)host andPort:(NSInteger)port;
/** Connects socket with remote host */
- (void)connect;
/** Disconnects socket from remote host */
- (void)disconnect;
/** Sends text message to host */
- (void)sendMessageString:(NSString *)msg;
/** Sends bytes to host */
- (void)sendMessageData:(NSData *)msg;

// Callbacks:

/** Callback for getting completion statues of connection process. @param message nil */
@property (copy, nonatomic) SocketConnectorMessageBlock didCompleteConnectionBlock;
- (void)setDidCompleteConnectionBlock:(SocketConnectorMessageBlock)didCompleteConnectionBlock;
/** Callback for reading messages from input stream. @param message NSString object. */
@property (copy, nonatomic) SocketConnectorMessageBlock didReceiveStringBlock;
- (void)setDidReceiveStringBlock:(SocketConnectorMessageBlock)didReceiveStringBlock;
/** Callback for reading messages from input stream. @param message NSData object. */
@property (copy, nonatomic) SocketConnectorMessageBlock didReceiveDataBlock;
- (void)setDidReceiveDataBlock:(SocketConnectorMessageBlock)didReceiveDataBlock;
/** Callback for getting errors. @param message NSError object. */
@property (copy, nonatomic) SocketConnectorMessageBlock didReceiveErrorBlock;
- (void)setDidReceiveErrorBlock:(SocketConnectorMessageBlock)didReceiveErrorBlock;

@end
