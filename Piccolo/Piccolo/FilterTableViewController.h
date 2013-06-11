//
//  FilterTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DifficultyDelegate.h"
#import "OriginalityDelegate.h"
#import "CountDownDelegate.h"

@protocol AddCocktailViewControllerDelegate;

@interface FilterTableViewController : UITableViewController <PassDifficulty, PassOriginality, PassCountDown>

@property (nonatomic, retain) id<AddCocktailViewControllerDelegate> delegate;
@property (nonatomic, retain) DifficultyDelegate* difficultyDelegate;
@property (nonatomic, retain) OriginalityDelegate* originalityDelegate;
@property (nonatomic, retain) CountDownDelegate* countDownDelegate;


@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *IngredientField;

@property (weak, nonatomic) IBOutlet UITextField *difficultyField;
@property (weak, nonatomic) IBOutlet UITextField *preparationField;
@property (weak, nonatomic) IBOutlet UITextField *originalityField;

@property NSInteger countDown;
@property BOOL alchool;


- (void) addNewCocktailController;

- (void) filterCocktailController;

@end
@protocol AddCocktailViewControllerDelegate <NSObject>

- (void) addCocktailDidCancel:(FilterTableViewController *)controller;
- (void) addCocktailDidSuccess:(FilterTableViewController *)controller;

@end