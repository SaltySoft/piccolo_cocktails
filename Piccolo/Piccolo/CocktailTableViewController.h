//
//  CocktailTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTableViewController.h"


@interface CocktailTableViewController : UITableViewController <AddCocktailViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray* cocktails;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)addCocktailAction:(id)sender;
- (IBAction)filterCocktailAction:(id)sender;


- (void) reloadData;

@end
