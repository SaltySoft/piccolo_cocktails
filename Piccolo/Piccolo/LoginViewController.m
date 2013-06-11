//
//  LoginViewController.m
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "LoginViewController.h"
#import "LoggedViewController.h"

#import "User.h"

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
                    didSuccess: (BOOL) result
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (result) {
            NSLog(@"sucess");
            [self pushLoggeControllerWithUsername:@"test"];
        } else {
            NSLog(@"failure");
            self.errorLabel.text = @"Failed to create a new account";
            [self.errorLabel setHidden:NO];
        }
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
    if ([self.loginField.text isEqualToString:username] && [self.passwordField.text isEqualToString:password]) {
        [self pushLoggeControllerWithUsername:@"test"];
    } else {
        [self.errorLabel setHidden:NO];
    }
}

- (IBAction)loginAction:(id)sender {
    [self logUserInWithUsername:@"test" andPassword:@"test"];
}

@end
