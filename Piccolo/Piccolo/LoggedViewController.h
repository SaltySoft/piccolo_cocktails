//
//  LoggedViewController.h
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoggedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *loggedLabel;

- (void) updateLoggedLabel:(NSString*) username;

@end
