//
//  LH_FirstViewController.m
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import "LH_Joystick_ViewController.h"

@interface LH_Joystick_ViewController ()

@end

@implementation LH_Joystick_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LH_WS = [[LH_WebSocket alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//NSNotification sendWebSocket
- (void) deallocJoystickNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) initJoystickNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveJoystickNotification:)
                                                 name:@"JoystickNotification"
                                               object:nil];
}

- (void) receiveJoystickNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"JoystickNotification"]){
        
        NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] initWithDictionary:(NSMutableDictionary*)[notification object]];
        int NotificationID = [[msgDictionary objectForKey:@"NotificationID"] intValue];
        NSString *NotificationMSG = [msgDictionary objectForKey:@"NotificationMSG"];
        
        switch (NotificationID) {
            case 1: //Connect
                [LH_WS connect:NotificationMSG];
                NSLog(@"Server: %@",NotificationMSG);
                break;
            case 2: //Disconnect
                [LH_WS.ws close];
                break;
            case 3:
                [LH_WS.ws sendText:NotificationMSG];
                NSLog(@"WebSocket Sent: %@",NotificationMSG);
                break;
                
            default:
                break;
        }
    }
}

@end
