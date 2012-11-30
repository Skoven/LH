//
//  LH_Rosbridge.h
//  LH Remote
//
//  Created by Jens Skov Damgaard on 30/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LH_Rosbridge : NSObject

- (NSString*) advertiseTopic:(NSString*)topic Type: (NSString*) type;

- (NSString*) publishTopic:(NSString*)topic Message: (NSMutableDictionary*) msg;

- (NSString*) subscribeTopic:(NSString*)topic Type: (NSMutableDictionary*) type;

@end
