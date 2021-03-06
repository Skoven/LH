//
//  LH_SecondViewController.m
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import "LH_Connection_ViewController.h"

@interface LH_Connection_ViewController ()

@end

@implementation LH_Connection_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textMessage.delegate = self;
    _ipTextField.delegate = self;
    
    _ipTextField.text = @"192.168.0.8:9090";
	// Do any additional setup after loading the view, typically from a nib.
    [self initConnectionNotification];
    
//    ConnectionImage = [UIImage imageNamed: @"red.png"];
//    
//    _connectStatus=[[UIImageView alloc] initWithImage:ConnectionImage];
//    [self.view addSubview:_connectStatus];
//    _connectStatus.frame = CGRectMake(60, 10, _connectStatus.frame.size.width/2, _connectStatus.frame.size.height/2);
//    
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
//    theAnimation.duration=1.5;
//    theAnimation.repeatCount=HUGE_VALF;
//    theAnimation.autoreverses=YES;
//    theAnimation.fromValue=[NSNumber numberWithFloat:0.9];
//    theAnimation.toValue=[NSNumber numberWithFloat:0.2];
//    [_connectStatus.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Connect:(id)sender {
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:1] forKey:@"NotificationID"];
    [msgDictionary setObject:_ipTextField.text forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JoystickNotification" object:msgDictionary];
    
}

- (IBAction)Clear:(id)sender {
    _WebSocketMessageField.text = [NSString stringWithFormat:@""];
}

- (IBAction)Disconnect:(id)sender {
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:2] forKey:@"NotificationID"];
    [msgDictionary setObject:@"" forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JoystickNotification" object:msgDictionary];
}

- (IBAction)Send:(id)sender {
    NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] init];
    
    [msgDictionary setObject:[NSNumber numberWithInt:3] forKey:@"NotificationID"];
    [msgDictionary setObject:_textMessage.text forKey:@"NotificationMSG"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JoystickNotification" object:msgDictionary];
}


//NSNotification receiveWebSocket
- (void) deallocConnectionNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) initConnectionNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveConnectionNotification:)
                                                 name:@"ConnectionNotification"
                                               object:nil];
}

- (void) receiveConnectionNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ConnectionNotification"]){
        
        NSMutableDictionary *msgDictionary = [[NSMutableDictionary alloc] initWithDictionary:(NSMutableDictionary*)[notification object]];
        
        int NotificationID = [[msgDictionary objectForKey:@"NotificationID"] intValue];
        NSString *NotificationMSG = [msgDictionary objectForKey:@"NotificationMSG"];
        
        
        switch (NotificationID) {
            case 1:
                _WebSocketMessageField.text = [NSString stringWithFormat:@"Socket is open for business.\n%@",_WebSocketMessageField.text];
                //ConnectionImage = [UIImage imageNamed: @"green.png"];
                //[_connectStatus setImage:ConnectionImage];
                break;
            case 2:
                _WebSocketMessageField.text = [NSString stringWithFormat:@"Oops. It closed:\n%@",_WebSocketMessageField.text];
                //ConnectionImage = [UIImage imageNamed: @"red.png"];
                //[_connectStatus setImage:ConnectionImage];
                break;
            case 3:
                _WebSocketMessageField.text = [NSString stringWithFormat:@"Oops. An error occurred.\n%@",_WebSocketMessageField.text];
                break;
            case 4:
                _WebSocketMessageField.text = [NSString stringWithFormat:@"Did receive message: %@\n%@",NotificationMSG,_WebSocketMessageField.text];
                break;
            case 5:
                _WebSocketMessageField.text = [NSString stringWithFormat:@"Yay! Pong was sent!\n%@",_WebSocketMessageField.text];
                break;
            default:
                break;
        }
    }
}


@end
