//
//  LH_WebSocket.h
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebSocket.h"

@interface LH_WebSocket : NSObject <WebSocketDelegate>
{
@private
    WebSocket* ws;
}

@property (nonatomic, readonly) WebSocket* ws;

//- (void)connect: (NSString*) ip;
- (void) startMyWebSocket;
- (void)connect: (NSString*) ip;

@end
