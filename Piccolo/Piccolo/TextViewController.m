//
//  TextViewController.m
//  Piccolo
//
//  Created by Irenicus on 09/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

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
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.passRecipe) {
        [self.passRecipeDelegate passRecipe:self.textView.text];
    }
    if (self.passDescription) {
        [self.passDescriptionDelegate passDescription:self.textView.text];
    }
}

- (BOOL) resignFirstResponder
{
    [self.textView resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
