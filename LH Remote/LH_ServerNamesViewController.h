//
//  LH_ServerNamesViewController.h
//  LH Remote
//
//  Created by Simon Bøgh on 29/11/12.
//  Copyright (c) 2012 AAU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LH_ServerNamesViewController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *ServerList;

- (IBAction)doneButton:(id)sender;
- (IBAction)addServer:(id)sender;

@end
