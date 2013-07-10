//
//  CocktailsByIngredientTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 07/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "CocktailsByIngredientTableViewController.h"
#import "CocktailCell.h"
#import "Cocktail.h"
#import "CocktailViewController.h"

@interface CocktailsByIngredientTableViewController ()

@end

@implementation CocktailsByIngredientTableViewController
@synthesize cocktails = _cocktails;

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

- (void) reloadData
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cocktails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"searchCocktailCell";
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
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CocktailViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"cocktailController"];
    [vc setCocktail:[_cocktails objectAtIndex:indexPath.row]];
    [vc setTitle:@"Detail"];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setViewAttributes];
}

@end
