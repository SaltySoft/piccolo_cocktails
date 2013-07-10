//
//  LoginViewController.h
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterTableViewController.h"

@interface LoginViewController : UIViewController <RegisterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIToolbar *loginAction;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;


- (IBAction)loginAction:(id)sender;

- (void) pushLoggeControllerWithUsername: (NSString*) username;


@end
