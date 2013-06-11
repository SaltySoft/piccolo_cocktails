//
//  RegisterTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "LoggedViewController.h"

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
    BOOL requestRes = YES;
    [_delegate registrationDidSuccess:self didSuccess:requestRes];
}

- (void)doneAction
{
    //TODO : Request create user to server
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    LoggedViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"loggedViewController"];
    [vc updateLoggedLabel:@"Test"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end