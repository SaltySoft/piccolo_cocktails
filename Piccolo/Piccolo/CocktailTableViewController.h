//
//  CocktailTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTableViewController.h"
#import "AddCocktailTableViewController.h"

@interface CocktailTableViewController : UITableViewController <AddCocktailViewControllerDelegate, FilterCocktailViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray* cocktails;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (void) reloadData;

- (void) addCocktailAction;

@end
