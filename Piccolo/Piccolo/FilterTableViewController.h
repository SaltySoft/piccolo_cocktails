//
//  FilterTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocktailsByIngredientTableViewController.h"
#import "CocktailAttributesViewController.h"


@protocol FilterCocktailViewControllerDelegate;

@interface FilterTableViewController : CocktailAttributesViewController <PassDifficulty, PassOriginality, PassCountDown>


@property (nonatomic, retain) id<FilterCocktailViewControllerDelegate> delegate;



@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *difficultyField;
@property (weak, nonatomic) IBOutlet UITextField *preparationField;
@property (weak, nonatomic) IBOutlet UITextField *originalityField;


- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;


@end


@protocol FilterCocktailViewControllerDelegate <NSObject>

- (void) filterCocktailDidCancel:(FilterTableViewController *)controller;
- (void) filterCocktailDidSuccess:(FilterTableViewController *)controller;

@end