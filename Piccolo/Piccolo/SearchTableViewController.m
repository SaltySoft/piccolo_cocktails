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
#import "CocktailRequest.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

@synthesize ingredients = _ingredients;
@synthesize selectedIngredients = _selectedIngredients;
@synthesize delegate = _delegate;

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

- (void) hideSearchButton
{
    self.navigationItem.rightBarButtonItem = nil;
}



- (IBAction)searchAction:(id)sender {
    NSMutableDictionary* ingredientsDic = [[NSMutableDictionary alloc] init];
    
    NSInteger index = 0;
    NSInteger numberOfIng = 1;
    NSMutableArray* ingredientKeys = [[NSMutableArray alloc] init];
    for (Ingredient* ing in self.ingredients) {
        BOOL isIngredientSelected = [[_selectedIngredients objectAtIndex:index] boolValue];
        if (isIngredientSelected) {
            [ingredientKeys addObject:[NSString stringWithFormat:@"%d",ing.id]];
            numberOfIng++;
        }
        index++;
    }
    [ingredientsDic setValue:ingredientKeys forKey:@"ingredient_ids"];
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
    
    if (self.delegate != nil) {
        NSMutableArray* ingredientsSelected = [[NSMutableArray alloc] init];
        NSInteger index = 0;
        for (Ingredient* ing in self.ingredients) {
            BOOL isIngredientSelected = [[_selectedIngredients objectAtIndex:index] boolValue];
            if (isIngredientSelected) {
                [ingredientsSelected addObject:ing];
            }
            index++;
        }
        [_delegate passIngredients:ingredientsSelected];
    }
}

@end
