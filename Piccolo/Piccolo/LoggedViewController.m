//
//  LoggedViewController.m
//  Piccolo
//
//  Created by Irenicus on 10/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "LoggedViewController.h"
#import "UserRequest.h"
#import "AppDelegate.h"

@interface LoggedViewController ()

@end

@implementation LoggedViewController

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
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(logout)];
}

- (void) logout
{
    [UserRequest logoutUserOnCompletion:^(NSString* message, NSError* error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate setUser:nil];
            [appDelegate setToken:nil];
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateLoggedLabel:(NSString*) username
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loggedLabel.text = [NSString stringWithFormat:@"You are logged as %@",username];
    });
}


@end
