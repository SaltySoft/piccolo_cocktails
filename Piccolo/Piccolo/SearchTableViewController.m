//
//  SearchTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "SearchTableViewController.h"
#import "Ingredient.h"
#import "CocktailsByIngredientTableViewController.h"
#import "CocktailRequest.m"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

@synthesize ingredients = _ingredients;
@synthesize selectedIngredients = _selectedIngredients;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (IBAction)searchAction:(id)sender {
    NSDictionary* ingredientsDic = nil;
    [CocktailRequest cocktailsByIngredients:ingredientsDic OnCompletion:^(NSArray* array, NSError* error) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            CocktailsByIngredientTableViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"CocktailsByIngredients"];
            [vc setCocktails:[[NSMutableArray alloc] initWithArray:array]];
            [self.navigationController pushViewController:vc animated:YES];
            [vc reloadData];
        });
    }];
}

- (void) initData
{
    _selectedIngredients = [[NSMutableArray alloc] initWithCapacity:_ingredients.count];
    for (int i = 0; i < _ingredients.count; i++) {
        [_selectedIngredients addObject:@"YES"];
    }
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
    return [_ingredients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IngredientCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Ingredient* ingredient = [_ingredients objectAtIndex:indexPath.row];
    cell.textLabel.text = ingredient.name;
    return cell;
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
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isIngredientSelected = [[_selectedIngredients objectAtIndex:indexPath.row] boolValue];
    if (isIngredientSelected) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    [_selectedIngredients replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:!isIngredientSelected]];
}

@end
