//
//  FilterTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "FilterTableViewController.h"
#import "Tools.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController
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
    [self.difficultyDelegate setDelegate:self];
    [self.originalityDelegate setDelegate:self];
    [self.countDownDelegate setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [super hideKeyboard];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath];
}




#pragma mark - Protocols

- (void) setOriginality: (NSString*) originality
{
    self.originalityField.text = originality;
}

- (void) setDifficulty: (NSString*) difficulty
{
    self.difficultyField.text = difficulty;
}


- (void) setCountDown: (NSInteger) countDown andCountDownString: (NSString*) countDownString
{
    self.preparationField.text = countDownString;
    self.countDown = countDown;
}

- (IBAction)cancelAction:(id)sender {
    [_delegate filterCocktailDidCancel:self];
}

- (IBAction)doneAction:(id)sender {
    [_delegate filterCocktailDidSuccess:self];
}
@end
