//
//  FilterTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "FilterTableViewController.h"

#import "Tools.h"

#import "CocktailRequest.h"

#include "Ingredient.h"

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

- (void) setOriginality: (NSString*) originality andOriginalityInt: (NSInteger) originalityInt
{
    self.originalityField.text = originality;
    self.originalityInt = originalityInt;
}

- (void) setDifficultyString: (NSString*) difficulty andDifficultyInt: (NSInteger) difficultyInt;
{
    self.difficultyField.text = difficulty;
    self.difficultyInt = difficultyInt;
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
    NSMutableDictionary *filter = [[NSMutableDictionary alloc] init];
    
    if ([[super ingredients] count] != 0) {
        NSMutableArray* ingredientIds = [[NSMutableArray alloc] init];
        
        for (Ingredient* ing in [super ingredients]) {
            [ingredientIds addObject:[NSString stringWithFormat:@"%d",ing.id]];
        }
        [filter setValue:ingredientIds forKey:@"ingredient_ids"];
    }
    

    
    if (self.nameField.text.length > 0) {
        [filter setValue:self.nameField.text forKey:@"name"];
    }
    if (self.difficultyField.text.length > 0) {
        [filter setValue:[NSString stringWithFormat:@"%d", self.difficultyInt ] forKey:@"difficulty"];
    }
    if (self.originalityField.text.length > 0) {
        [filter setValue:[NSString stringWithFormat:@"%d", self.originalityInt ] forKey:@"originality"];
    }
    if (self.preparationField.text.length > 0) {
        [filter setValue:[NSString stringWithFormat:@"%d", [super countDown] ] forKey:@"duration"];
    }
    [filter setValue:[NSString stringWithFormat:@"%d", [super alchool]] forKey:@"alchohol"];
    
    NSLog(@"%@",filter);
    [CocktailRequest cocktailsFilter:filter OnCompletion:^(NSArray* cocktails, NSError* error) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (error == nil && cocktails != nil) {
                [_delegate filterCocktailDidSuccess:self RefreshCocktails:cocktails];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"You must be connected to use this feature." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        });
    }];
}
@end
