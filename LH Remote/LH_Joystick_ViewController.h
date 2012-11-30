//
//  LH_FirstViewController.h
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LH_WebSocket.h"
#import "LH_Rosbridge.h"

@interface LH_Joystick_ViewController : UIViewController {
    LH_WebSocket* LH_WS;
    LH_Rosbridge* myRos;
}

@property (nonatomic, retain) IBOutlet UITextField *CoordTextField;
@property (nonatomic, retain) IBOutlet UIImageView *ballControl;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundControl;

@end
