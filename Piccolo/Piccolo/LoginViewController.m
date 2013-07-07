//
//  LoginViewController.m
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "LoginViewController.h"
#import "LoggedViewController.h"
#import "UserRequest.h"
#import "User.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

    // Do any additional setup after loading the view.

}




- (void) hideKeyboard {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}

- (void)registrationDidCancel:(RegisterTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)registrationDidSuccess:(RegisterTableViewController *)controller
                    withUser: (User*) user
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self pushLoggeControllerWithUsername:user.username];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"registerSegue"]) {
        RegisterTableViewController *registerViewController = (RegisterTableViewController*)
        [[[segue destinationViewController] viewControllers] objectAtIndex:0];
        registerViewController.delegate = self;
    }
}

- (void) pushLoggeControllerWithUsername: (NSString*) username
{
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    LoggedViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"loggedViewController"];
    [vc updateLoggedLabel:username];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) logUserInWithUsername: (NSString*) username andPassword: (NSString*) password
{
    if (self.loginField.text.length > 0 && self.passwordField.text.length > 0) {
        NSArray *keys = [[NSArray alloc] initWithObjects:
                         @"name" ,
                         @"password",
                         nil];
        NSArray *values = [[NSArray alloc] initWithObjects:username, password, nil];
        NSDictionary* userForm = [[NSDictionary alloc] initWithObjects:values
                                                               forKeys:keys];
        [UserRequest loginUserWithUser:userForm onCompletion:^(User* user,NSString* token, NSString* error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (user != nil && token != nil) {
                    [self pushLoggeControllerWithUsername:username];
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [appDelegate setToken:token];
                    [appDelegate setUser:user];
                } else {
                    if (error != nil) {
                        self.errorLabel.text = error;
                        [self.errorLabel setHidden:NO];
                    }
                }
            });
        }];
    } else {
        self.errorLabel.text = @"You must provide a username and a password";
        [self.errorLabel setHidden:NO];
    }
}

- (IBAction)loginAction:(id)sender {
    [self logUserInWithUsername:self.loginField.text andPassword:self.passwordField.text];
    [self hideKeyboard];
}

@end
