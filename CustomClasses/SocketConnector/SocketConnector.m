//
//  SocketConnector.m
//  Utils
//
//  Created by Mykola Denysyuk on 2/19/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

#import "SocketConnector.h"

#define kDefaultEncoding NSASCIIStringEncoding

//--------------------------------------------------------------------
@interface SocketConnector () {
    @protected
    NSData * _lastReadMessage;
    SocketConnectorMode _streamReady;
}
@property (strong, nonatomic) NSInputStream * inputStream;
@property (strong, nonatomic) NSOutputStream * outputStream;
@property (strong, nonatomic) NSMutableArray <NSData *> * sentMessagesQueue;
@end

//--------------------------------------------------------------------
@implementation SocketConnector

#pragma mark - Initialization:

- (instancetype)init {
    [NSException raise:@"simple init is forbidden"
                format:@"use -initWithHost:andPort:mode: instead"];
    return [self initWithHost:nil
                      andPort:0];
}

- (instancetype)initWithHost:(NSString *)host andPort:(NSInteger)port mode:(SocketConnectorMode)mode {
    if (self = [super init]) {
        _host = host;
        _port = port;
        _mode = mode;
        
        switch (mode) {
            case SocketConnectorReadWrite: {
                CFReadStreamRef readStream;
                CFWriteStreamRef writeStream;
                CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, (UInt32)port, &readStream, &writeStream);
                _inputStream = (__bridge NSInputStream*)readStream;
                _outputStream = (__bridge NSOutputStream *)writeStream;
                break;
            }
            case SocketConnectorRead: {
                CFReadStreamRef readStream;
                CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, (UInt32)port, &readStream, NULL);
                _inputStream = (__bridge NSInputStream*)readStream;
                break;
            }
            case SocketConnectorWrite: {
                CFWriteStreamRef writeStream;
                CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, (UInt32)port, NULL, &writeStream);
                _outputStream = (__bridge NSOutputStream *)writeStream;
                break;
            }
        }
    }
    return self;
}

- (instancetype)initWithHost:(NSString *)host andPort:(NSInteger)port {
    return [self initWithHost:host
                      andPort:port
                         mode:SocketConnectorReadWrite];
}

#pragma mark - Accessors:

- (NSMutableArray *)sentMessagesQueue {
    if (!_sentMessagesQueue) {
        _sentMessagesQueue = [NSMutableArray arrayWithCapacity:2];
    }
    return _sentMessagesQueue;
}

- (void)setDidReceiveDataBlock:(SocketConnectorMessageBlock)didReceiveDataBlock {
    NSAssert(self.inputStream, @"Socket was not created for read mode");
    _didReceiveDataBlock = [didReceiveDataBlock copy];
}

- (void)setDidReceiveStringBlock:(SocketConnectorMessageBlock)didReceiveStringBlock {
    NSAssert(self.inputStream, @"Socket was not created for read mode");
    _didReceiveStringBlock = [didReceiveStringBlock copy];
}

#pragma mark - NSStreamDelegate:

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventNone: {
            // none
            break;
        }
        case NSStreamEventOpenCompleted: {
            if (aStream == self.inputStream) {
                _streamReady |= SocketConnectorRead;
            } else if (aStream == self.outputStream) {
                _streamReady |= SocketConnectorWrite;
            }
            if (_streamReady == _mode && self.didCompleteConnectionBlock) {
                self.didCompleteConnectionBlock(nil);
            }
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            if (aStream == self.inputStream) {
                
                uint8_t buffer[1024];
                NSInteger length = 0;
                NSMutableData * inputData = [NSMutableData new];
                
                while ([self.inputStream hasBytesAvailable]) {
                    length = [self.inputStream read:buffer
                                          maxLength:sizeof(buffer)];
                    if (length) {
                        [inputData appendBytes:buffer
                                        length:length];
                    }
                }
                _lastReadMessage = inputData.copy;
                if (self.didReceiveDataBlock) {
                    self.didReceiveDataBlock(_lastReadMessage);
                } else if (self.didReceiveStringBlock) {
                    NSString * messageString = [[NSString alloc] initWithData:_lastReadMessage encoding:kDefaultEncoding];
                    self.didReceiveStringBlock(messageString);
                }
            }
            break;
        }
        case NSStreamEventHasSpaceAvailable: {
            if (aStream == self.outputStream) {
                [self p_handleSentMessagesQueue];
            }
            break;
        }
        case NSStreamEventErrorOccurred: {
            NSLog(@"smth went wrong");
            if (self.didReceiveErrorBlock) {
                NSString * errorMessage = [NSString stringWithFormat:@"Cannot connect to host %@", self.host];
                self.didReceiveErrorBlock([NSError errorWithDomain:@"SocketConnector"
                                                              code:-1
                                                          userInfo:@{NSLocalizedDescriptionKey: errorMessage}]);
            }
            break;
        }
        case NSStreamEventEndEncountered: {
            [self p_closeStream:aStream];
            break;
        }
    }
}

#pragma mark - Actions:

- (void)connect {
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                            forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                             forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    [_outputStream open];
}

- (void)disconnect {
    [self p_closeStream:_inputStream];
    [self p_closeStream:_outputStream];
}

- (void)p_closeStream:(NSStream *)stream {
    [stream close];
    [stream removeFromRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
    stream.delegate = nil;
}

- (void)sendMessageString:(NSString *)msg {
    if (msg) {
        NSData * msgData = [msg dataUsingEncoding:kDefaultEncoding];
        [self sendMessageData:msgData];
    }
}

- (void)sendMessageData:(NSData *)msg {
    NSAssert(self.outputStream, @"Socket was not created for write mode");
    @synchronized(self) {
        [self.sentMessagesQueue addObject:msg];
        // force to handle write queue is output stream is ready,
        // otherwise - wait until it will become ready. (@see stream:handleEvent:)
        if ([self.outputStream hasSpaceAvailable]) {
            [self p_handleSentMessagesQueue];
        }
    }
}

- (void)p_handleSentMessagesQueue {
    // try to send messages from queue if any exist and output stream is ready
    while (_sentMessagesQueue.count && self.outputStream.hasSpaceAvailable) {
        NSData * messageData = [self.sentMessagesQueue firstObject];
        [self.sentMessagesQueue removeObjectAtIndex:0];
        [self.outputStream write:messageData.bytes
                       maxLength:messageData.length];
    }
}

@end
