//
//  FavoriteTableViewController.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteTableViewController : UITableViewController

@property (nonatomic, retain) NSArray* cocktails;

- (void) reloadData;

@end
