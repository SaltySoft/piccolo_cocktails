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
#import "DetailedCocktailViewController.h"

@interface CocktailTableViewController ()

@end

@implementation CocktailTableViewController

@synthesize cocktails = _cocktails;

- (void) reloadData
{
    [self.tableView reloadData];
}

- (FilterTableViewController*) pushFilterView
{
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FilterTableViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"filterCocktail"];
    [self.navigationController pushViewController:vc animated:YES];
    return vc;
}

- (IBAction)filterCocktailAction:(id)sender {
    FilterTableViewController *vc = [self pushFilterView];
    [vc filterCocktailController];
}

- (IBAction)addCocktailAction:(id)sender {
    FilterTableViewController *vc = [self pushFilterView];
    [vc addNewCocktailController];

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_cocktails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cocktailCell";
    CocktailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Cocktail* c = [_cocktails objectAtIndex:indexPath.row];
    cell.name.text = [c name];
    cell.difficulty.text = [c difficulty];
    cell.image.image = [c picture];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DetailedCocktailViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"detailedCocktailController"];
    [vc setCocktail:[_cocktails objectAtIndex:indexPath.row]];
    [vc setAsDetailedView];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addCocktailSegue"]) {
        FilterTableViewController *addCocktailController = (FilterTableViewController*)
        [[[segue destinationViewController] viewControllers] objectAtIndex:0];
        [addCocktailController addNewCocktailController];
        addCocktailController.delegate = self;
    }
}

#pragma mark - Protocol AddCocktailViewControllerDelegate


- (void) addCocktailDidCancel:(FilterTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) addCocktailDidSuccess:(FilterTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        //todo : addRequest and refresh
    }];
}





@end
