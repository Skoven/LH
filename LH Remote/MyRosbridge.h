//
//  MyRosbridge.h
//  LH Websocket
//
//  Created by Jens Skov Damgaard on 22/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRosbridge : NSObject
{
}

- (NSString*) advertiseTopic:(NSString*)topic Type: (NSString*) type;

- (NSString*) publishTopic:(NSString*)topic Message: (NSMutableDictionary*) msg;

- (NSString*) subscribeTopic:(NSString*)topic Type: (NSMutableDictionary*) type;


@end
