//
//  LH_SecondViewController.h
//  LH Remote
//
//  Created by Jens Skov Damgaard on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LH_Connection_ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UITextView *WebSocketMessageField;
@property (weak, nonatomic) IBOutlet UITextField *textMessage;
@property (nonatomic, retain) IBOutlet UIImageView *connectStatus;

- (IBAction)Connect:(id)sender;
- (IBAction)Clear:(id)sender;
- (IBAction)Disconnect:(id)sender;
- (IBAction)Send:(id)sender;

@end
