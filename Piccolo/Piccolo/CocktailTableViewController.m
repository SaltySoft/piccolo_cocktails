//
//  CocktailTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "CocktailTableViewController.h"
#import "CocktailCell.h"
#import "Cocktail.h"
#import "CocktailViewController.h"
#import "AppDelegate.h"

@interface CocktailTableViewController ()

@end

@implementation CocktailTableViewController

@synthesize cocktails = _cocktails;

- (void) reloadData
{
    [self.tableView reloadData];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate isAuthenticated]) {
        [self addFavoriteButton];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (FilterTableViewController*) pushFilterView
{
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FilterTableViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"filterCocktail"];
    [self.navigationController pushViewController:vc animated:YES];
    return vc;
}

- (void) addFavoriteButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCocktailAction)];
}

- (void) addCocktailAction
{
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"addCocktailNav"];
    [self.navigationController presentViewController:vc animated:YES completion:NULL];
    AddCocktailTableViewController* ac = [vc.childViewControllers objectAtIndex:0];
    [ac setDelegate:self];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cocktails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cocktailCell";
    CocktailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Cocktail* c = [_cocktails objectAtIndex:indexPath.row];
    cell.name.text = [c name];
    cell.difficulty.text = [c difficulty];
    if (c.picture) {
        cell.image.image = [c picture];
    } else {
        NSString *no_picture = [[NSBundle mainBundle] pathForResource:@"no_picture" ofType:@"png"];
        cell.image.image = [[UIImage alloc] initWithContentsOfFile:no_picture];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CocktailViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"cocktailController"];
    [vc setCocktail:[_cocktails objectAtIndex:indexPath.row]];
    [vc setTitle:@"Detail"];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setViewAttributes];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"filterSegue"]) {
        FilterTableViewController *fc = (FilterTableViewController*)
        [[[segue destinationViewController] viewControllers] objectAtIndex:0];
        fc.delegate = self;
    }
}

#pragma mark - Protocol AddCocktailViewControllerDelegate


- (void) addCocktailDidCancel:(AddCocktailTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) addCocktailDidSuccess:(AddCocktailTableViewController *)controller cocktail:(Cocktail*) cocktail;
{
    [self dismissViewControllerAnimated:YES completion:^{
        [_cocktails addObject:cocktail];
        [self.tableView reloadData];
    }];
}

#pragma mark - Protocol FilterTableViewControllerDelegate


- (void) filterCocktailDidCancel:(FilterTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) filterCocktailDidSuccess:(FilterTableViewController *)controller RefreshCocktails:(NSArray*) cocktails
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.cocktails = [[NSMutableArray alloc] initWithArray:cocktails];
        [self.tableView reloadData];
    }];
}





@end
