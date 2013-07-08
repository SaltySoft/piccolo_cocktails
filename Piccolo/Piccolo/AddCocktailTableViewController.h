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

@protocol AddCocktailViewControllerDelegate;
@interface AddCocktailTableViewController : CocktailAttributesViewController  <PassDifficulty, PassOriginality, PassCountDown, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) id<AddCocktailViewControllerDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *difficultyField;
@property (weak, nonatomic) IBOutlet UITextField *preparationField;
@property (weak, nonatomic) IBOutlet UITextField *originalityField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

@protocol AddCocktailViewControllerDelegate <NSObject>

- (void) addCocktailDidCancel:(AddCocktailTableViewController *)controller;
- (void) addCocktailDidSuccess:(AddCocktailTableViewController *)controller;

@end