//
//  AddCocktailTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 08/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocktailsByIngredientTableViewController.h"
#import "CocktailAttributesViewController.h"
#import "Cocktail.h"
#import "TextViewController.h"

@protocol AddCocktailViewControllerDelegate;
@interface AddCocktailTableViewController : CocktailAttributesViewController  <PassDifficulty, PassOriginality, PassCountDown, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PassRecipe, PassDescription>

@property (nonatomic, retain) id<AddCocktailViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* recipe;
@property (nonatomic, retain) NSString* url;


@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *difficultyField;
@property (weak, nonatomic) IBOutlet UITextField *preparationField;
@property (weak, nonatomic) IBOutlet UITextField *originalityField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property NSInteger difficultyInt;
@property NSInteger originalityInt;


- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

@protocol AddCocktailViewControllerDelegate <NSObject>

- (void) addCocktailDidCancel:(AddCocktailTableViewController *)controller;
- (void) addCocktailDidSuccess:(AddCocktailTableViewController *)controller cocktail:(Cocktail*) cocktail;

@end