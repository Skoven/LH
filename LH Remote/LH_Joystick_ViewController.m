//
//  LH_FirstViewController.m
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import "LH_Joystick_ViewController.h"

@interface LH_Joystick_ViewController (){
    UITouch* touchMain;
    CGPoint locationUB;
    CGPoint locationULH;
    CGPoint joystickCenter;
    CGPoint joystickCenterTEST;
    bool pauseTimer;
    CGRect tempImageFrame;
    CGRect tabbar;
    CGRect JoyStickFrame;
    float joystickMaxY;
    float joystickMaxX;
}

@end

@implementation LH_Joystick_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    tabbar = CGRectMake(0, 480, 320, 49);
    JoyStickFrame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - tabbar.size.height);
    
    joystickMaxY = 150;
    joystickMaxX = 100;
    
    joystickCenter.x = JoyStickFrame.size.width/2;
    joystickCenter.y = JoyStickFrame.size.height/2; //Removes the tabbar
    
    
    NSString *coord = [NSString stringWithFormat:@"X = %.4f, TH = %.4f", 0.000, 0.000];
    NSLog(@"%@",coord);
    _CoordTextField.text = [NSString stringWithFormat:@"%@",coord];
    
    _backgroundControl=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows_4.png"]];
    [self.view addSubview:_backgroundControl];
    _backgroundControl.frame = CGRectMake(joystickCenter.x - _backgroundControl.frame.size.width/2/2, joystickCenter.y - _backgroundControl.frame.size.height/2/2, _backgroundControl.frame.size.width/2, _backgroundControl.frame.size.height/2);
    
    _ballControl=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    [self.view addSubview:_ballControl];
    _ballControl.frame = CGRectMake(joystickCenter.x - _ballControl.frame.size.width/2, joystickCenter.y - _ballControl.frame.size.height/2, _ballControl.frame.size.width, _ballControl.frame.size.height);
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(UpdateBall:)
                                   userInfo:nil
                                    repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(UpdateLH:)
                                   userInfo:nil
                                    repeats:YES];
    
    pauseTimer = TRUE;
    
    [self initJoystickNotification];

    LH_WS = [[LH_WebSocket alloc] init];
    
}


- (void) UpdateBall:(NSTimer *) timer {
    if (!pauseTimer) {
        locationUB = [touchMain locationInView: touchMain.view];
        
        if (locationUB.x >= (joystickCenter.x + joystickMaxX)) {
            locationUB.x = joystickCenter.x + joystickMaxX;
        } else if (locationUB.x <= (joystickCenter.x - joystickMaxX)){
            locationUB.x = joystickCenter.x - joystickMaxX;
        }
        
        if (locationUB.y >= (joystickCenter.y + joystickMaxY)) {
            locationUB.y = joystickCenter.y + joystickMaxY;
        } else if (locationUB.y <= (joystickCenter.y - joystickMaxY)){
            locationUB.y = joystickCenter.y - joystickMaxY;
        }
        
        tempImageFrame = _ballControl.frame;
        tempImageFrame.origin.x = locationUB.x-_ballControl.frame.size.width/2;
        tempImageFrame.origin.y = locationUB.y-_ballControl.frame.size.height/2;
        _ballControl.frame = tempImageFrame;
    }
}

- (void) UpdateLH:(NSTimer *) timer {
    if (!pauseTimer) {
        locationULH = [touchMain locationInView: touchMain.view];
        
        if (locationULH.x >= (joystickCenter.x + joystickMaxX)) {
            locationULH.x = joystickCenter.x + joystickMaxX;
        } else if (locationULH.x <= (joystickCenter.x - joystickMaxX)){
            locationULH.x = joystickCenter.x - joystickMaxX;
        }
        
        if (locationULH.y >= (joystickCenter.y + joystickMaxY)) {
            locationULH.y = joystickCenter.y + joystickMaxY;
        } else if (locationULH.y <= (joystickCenter.y - joystickMaxY)){
            locationULH.y = joystickCenter.y - joystickMaxY;
        }
        
        [self cmd_vel:locationULH];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    touchMain = [[event allTouches] anyObject];
    pauseTimer = FALSE;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    pauseTimer = TRUE;
    locationULH.x = joystickCenter.x;
    locationULH.y = joystickCenter.y;
    locationUB.x = joystickCenter.x;
    locationUB.y = joystickCenter.y;
    
    [self cmd_vel:locationULH];
    
    tempImageFrame = _ballControl.frame;
    tempImageFrame.origin.x = locationUB.x-_ballControl.frame.size.width/2;
    tempImageFrame.origin.y = locationUB.y-_ballControl.frame.size.height/2;
    _ballControl.frame = tempImageFrame;
}

#pragma mark - /cmd_vel json message
-(void)cmd_vel: (CGPoint) locationLH {
    
    double vel_x;
    double ang_z;
    
    if (locationLH.x == joystickCenter.x && locationLH.y == joystickCenter.y) {
        vel_x = 0.0;
        ang_z = 0.0;
    } else {
        vel_x = -(locationLH.y - joystickCenter.y)/joystickMaxY;
        ang_z = -(locationLH.x - joystickCenter.x)/joystickMaxX;
    }
    
    NSString *coord = [NSString stringWithFormat:@"X = %.4f, TH = %.4f", vel_x, ang_z];
    NSLog(@"%@",coord);
    _CoordTextField.text = [NSString stringWithFormat:@"%@",coord];
    
    NSMutableDictionary *Msg_Dictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *Msg_linear_Dictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *Msg_angular_Dictionary = [[NSMutableDictionary alloc] init];    
  
    [Msg_linear_Dictionary setObject:[NSNumber numberWithDouble:vel_x] forKey:@"x"];
    [Msg_linear_Dictionary setObject:[NSNumber numberWithDouble:0] forKey:@"y"];
    [Msg_linear_Dictionary setObject:[NSNumber numberWithDouble:0] forKey:@"z"];
    
    [Msg_angular_Dictionary setObject:[NSNumber numberWithDouble:0] forKey:@"x"];
    [Msg_angular_Dictionary setObject:[NSNumber numberWithDouble:0] forKey:@"y"];
    [Msg_angular_Dictionary setObject:[NSNumber numberWithDouble:ang_z] forKey:@"z"];
    
    [Msg_Dictionary setObject:Msg_linear_Dictionary forKey:@"linear"];
    [Msg_Dictionary setObject:Msg_angular_Dictionary forKey:@"angular"];
    
    
    NSLog(@"%@",[myRos publishTopic:@"/cmd_vel" Message:Msg_Dictionary]);
    
    //[LH_WS.ws sendText:[myRos publishTopic:@"/cmd_vel" Message:Msg_Dictionary]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notification Center
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
        
        NSLog(@"TEST");
        
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
