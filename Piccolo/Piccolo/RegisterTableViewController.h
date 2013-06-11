//
//  RegisterTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegisterTableViewController.h"


@protocol RegisterViewControllerDelegate;


@interface RegisterTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;

@property (retain, nonatomic) id<RegisterViewControllerDelegate> delegate;

- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;


@end

@protocol RegisterViewControllerDelegate <NSObject>

- (void)registrationDidCancel:(RegisterTableViewController *)controller;
- (void)registrationDidSuccess:(RegisterTableViewController *)controller
                  didSuccess: (BOOL) result;

@end