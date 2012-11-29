//
//  MyRosbridge.m
//  LH Websocket
//
//  Created by Jens Skov Damgaard on 22/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import "MyRosbridge.h"

@implementation MyRosbridge


- (NSString*) advertiseTopic:(NSString*)topic Type: (NSString*) type{
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setObject:@"advertise" forKey:@"op"];
    [myDictionary setObject:topic forKey:@"topic"];
    [myDictionary setObject:type forKey:@"type"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:myDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonSummary;
}

- (NSString*) publishTopic:(NSString*)topic Message: (NSMutableDictionary*) msg{
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setObject:@"publish" forKey:@"op"];
    [myDictionary setObject:topic forKey:@"topic"];
    [myDictionary setObject:msg forKey:@"msg"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:myDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonSummary;
}

- (NSString*) subscribeTopic:(NSString*)topic Type: (NSMutableDictionary*) type{
    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setObject:@"subscribe" forKey:@"op"];
    [myDictionary setObject:topic forKey:@"topic"];
    [myDictionary setObject:type forKey:@"type"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:myDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonSummary;
}

@end
