//
//  CocktailAttributesViewController.h
//  Piccolo
//
//  Created by Irenicus on 08/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DifficultyDelegate.h"
#import "OriginalityDelegate.h"
#import "CountDownDelegate.h"
#import "SearchTableViewController.h"

@interface CocktailAttributesViewController : UITableViewController<PassIngredient>

@property (nonatomic, retain) NSMutableArray* ingredients;

@property (nonatomic, retain) DifficultyDelegate* difficultyDelegate;
@property (nonatomic, retain) OriginalityDelegate* originalityDelegate;
@property (nonatomic, retain) CountDownDelegate* countDownDelegate;

@property NSInteger countDown;
@property BOOL alchool;

- (void) hideKeyboard;

@end

