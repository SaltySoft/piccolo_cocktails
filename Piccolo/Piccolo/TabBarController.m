//
//  TabBarController.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "TabBarController.h"
#import "CocktailRequest.h"
#import "IngredientRequest.h"
#import "CocktailTableViewController.h"
#import "FavoriteTableViewController.h"
#import "SearchTableViewController.h"
#import "DetailedCocktailViewController.h"
#import "DayCocktailViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [CocktailRequest getCocktailOfTheDayOnCompletion:^(Cocktail* c, NSError * error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (c == nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"You must be connected to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                UINavigationController* nc = [self.viewControllers objectAtIndex:0];
                DayCocktailViewController* ct = [nc.viewControllers objectAtIndex:0];
                ct.cocktail = c;
                [ct setViewAttributes];
            }
        });
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        [CocktailRequest getCocktailOfTheDayOnCompletion:^(Cocktail* c, NSError * error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (c == nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"You must be connected to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UINavigationController* nc = [self.viewControllers objectAtIndex:0];
                    DayCocktailViewController* ct = [nc.viewControllers objectAtIndex:0];
                    ct.cocktail = c;
                    [ct setViewAttributes];
                }
            });
        }];
    }
    if (item.tag == 1) {
        [CocktailRequest getCocktailListOnCompletion:^(NSArray * cocktails, NSError* err){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cocktails == nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"You must be connected to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UINavigationController* nc = [self.viewControllers objectAtIndex:1];
                    CocktailTableViewController* ct = [nc.viewControllers objectAtIndex:0];
                    ct.cocktails = [NSMutableArray arrayWithArray:cocktails];
                    [ct reloadData];
                }
            });
        }];
    }
    if (item.tag == 2) {
        [IngredientRequest getIngredientListOnCompletion:^(NSArray * ingredients, NSError* err){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (ingredients == nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"You must be connected to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UINavigationController* nc = [self.viewControllers objectAtIndex:2];
                    SearchTableViewController* ct = [nc.viewControllers objectAtIndex:0];
                    [ct setIngredients:ingredients];
                    [ct initData];
                }
            });
        }];
    }
    if (item.tag == 3) {
        [CocktailRequest getFavoritesListOnCompletion:^(NSArray * favorites, NSError* err){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (favorites == nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"You must be connected to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UINavigationController* nc = [self.viewControllers objectAtIndex:3];
                    FavoriteTableViewController* ct = [nc.viewControllers objectAtIndex:0];
                    ct.cocktails = [NSMutableArray arrayWithArray:favorites];
                    [ct reloadData];
                }
            });
        }];
    }
}



@end
