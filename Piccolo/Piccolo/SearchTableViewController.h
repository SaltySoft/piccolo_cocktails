//
//  SearchTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController

@property (nonatomic, retain) NSArray* ingredients;
@property (nonatomic, retain) NSMutableArray* selectedIngredients;
- (IBAction)searchAction:(id)sender;


- (void) initData;


@end
