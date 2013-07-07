//
//  RegisterTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "LoggedViewController.h"
#import "UserRequest.h"
#import "AppDelegate.h"

@interface RegisterTableViewController ()

@end

@implementation RegisterTableViewController

@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    
}




- (void) hideKeyboard {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelAction:(id)sender {
    [_delegate registrationDidCancel:self];
}

- (IBAction)doneAction:(id)sender {
    
    if (self.usernameField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Username invalid" message:@"You must provide a username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (self.passwordField.text.length == 0 || self.passwordConfirmField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Password invalid" message:@"You must provide a password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (![self.passwordField.text isEqualToString:self.passwordConfirmField.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Passwords invalids" message:@"The two passwords aren't the same." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (self.emailField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"E-mail is invalid" message:@"You must provide an e-mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSArray *keys = [[NSArray alloc] initWithObjects:
                         @"name" ,
                         @"mail",
                         @"password",
                         nil];
        NSArray *values = [[NSArray alloc] initWithObjects:
                           self.usernameField.text,
                           self.emailField.text,
                           self.passwordField.text, nil];
        NSDictionary* userForm = [[NSDictionary alloc] initWithObjects:values
                                                               forKeys:keys];
        [UserRequest createUserWithUser:userForm onCompletion:^(User* user, NSString* token, NSString* error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (user != nil && token != nil) {
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [appDelegate setToken:token];
                    [appDelegate setUser:user];
                    [_delegate registrationDidSuccess:self withUser:user];
                } else if (error != nil) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Subscription error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            });
        }];
    }
}

@end