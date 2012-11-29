//
//  LH_WebSocket.m
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import "LH_WebSocket.h"

@implementation LH_WebSocket

@synthesize ws;

#pragma mark Web Socket
- (void) startMyWebSocket
{
    [self.ws open];
    
    //continue processing other stuff
    //...
}

#pragma mark Lifecycle
- (void)connect: (NSString*) ip
{
    [self.ws close];
    //make sure to use the right url, it must point to your specific web socket endpoint or the handshake will fail
    //create a connect config and set all our info here
    WebSocketConnectConfig* config = [WebSocketConnectConfig configWithURLString:[NSString stringWithFormat:@"ws://%@",ip] origin:nil protocols:nil tlsSettings:nil headers:nil verifySecurityKey:YES extensions:nil ];
    config.closeTimeout = 15.0;
    config.keepAlive = 15.0; //sends a ws ping every 15s to keep socket alive
    
    //open using the connect config, it will be populated with server info, such as selected protocol/etc
    ws = [WebSocket webSocketWithConfig:config delegate:self];
    [self.ws open];
}


#pragma mark Web Socket
/**
 * Called when the web socket connects and is ready for reading and writing.
 **/
- (void) didOpen
{
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:1] forKey:@"NotificationID"];
    [msgDictionary setObject:@"" forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionNotification" object:msgDictionary];
    
    NSLog(@"TEST2");
}

/**
 * Called when the web socket closes. aError will be nil if it closes cleanly.
 **/
- (void) didClose:(NSUInteger) aStatusCode message:(NSString*) aMessage error:(NSError*) aError
{
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:2] forKey:@"NotificationID"];
    [msgDictionary setObject:@"" forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionNotification" object:msgDictionary];
}

/**
 * Called when the web socket receives an error. Such an error can result in the
 socket being closed.
 **/
- (void) didReceiveError:(NSError*) aError
{
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:3] forKey:@"NotificationID"];
    [msgDictionary setObject:@"" forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionNotification" object:msgDictionary];
    
}

/**
 * Called when the web socket receives a message.
 **/
- (void) didReceiveTextMessage:(NSString*) aMessage
{
    //Hooray! I got a message to print.
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:4] forKey:@"NotificationID"];
    [msgDictionary setObject:aMessage forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionNotification" object:msgDictionary];
}

/**
 * Called when the web socket receives a message.
 **/
- (void) didReceiveBinaryMessage:(NSData*) aMessage
{
    //Hooray! I got a binary message.
}

/**
 * Called when pong is sent... For keep-alive optimization.
 **/
- (void) didSendPong:(NSData*) aMessage
{
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:5] forKey:@"NotificationID"];
    [msgDictionary setObject:@"" forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionNotification" object:msgDictionary];
}



@end
