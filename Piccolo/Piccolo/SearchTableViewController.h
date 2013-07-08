//
//  SearchTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PassIngredient <NSObject>

- (void) passIngredients:(NSMutableArray*) ingredients;

@end

@interface SearchTableViewController : UITableViewController

@property (nonatomic, retain) id<PassIngredient> delegate;

@property (nonatomic, retain) NSArray* ingredients;
@property (nonatomic, retain) NSMutableArray* selectedIngredients;

- (IBAction)searchAction:(id)sender;

- (void) initData;

- (void) hideSearchButton;

@end
