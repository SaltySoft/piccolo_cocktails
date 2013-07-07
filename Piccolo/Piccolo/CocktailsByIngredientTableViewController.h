//
//  CocktailsByIngredientTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 07/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CocktailsByIngredientTableViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray* cocktails;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void) reloadData;

@end
