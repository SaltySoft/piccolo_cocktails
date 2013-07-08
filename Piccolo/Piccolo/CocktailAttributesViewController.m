//
//  CocktailAttributesViewController.m
//  Piccolo
//
//  Created by Irenicus on 08/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "CocktailAttributesViewController.h"
#import "IngredientRequest.h"
#import "SearchTableViewController.h"

@interface CocktailAttributesViewController ()

@end

@implementation CocktailAttributesViewController

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
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    self.alchool = TRUE;
    [self.view addGestureRecognizer:gestureRecognizer];
    self.difficultyDelegate = [[DifficultyDelegate alloc] init];
    self.originalityDelegate = [[OriginalityDelegate alloc] init];
    self.countDownDelegate = [[CountDownDelegate alloc] init];

}

- (void) hideKeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) actionSheetWithTitle: (NSString*) title
                        atRow: (NSInteger) row
               withDefaultRow: (NSInteger) defaultRow
                  andDelegate: (id<UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>) del
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:del
                                                    cancelButtonTitle:@"Done"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    actionSheet.tag = row;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,100, 320, 216)];
    picker.dataSource = del;
    picker.delegate = del;
    [picker selectRow:defaultRow inComponent:0 animated:YES];
    [actionSheet addSubview:picker];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0,0, 320, 411)];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [IngredientRequest getIngredientListOnCompletion:^(NSArray * ingredients, NSError* err){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                    SearchTableViewController *ct = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ingredientController"];
                    [self.navigationController pushViewController:ct animated:YES];
                    [ct setIngredients:ingredients];
                    [ct initData];
                    [ct hideSearchButton];
                    [ct setDelegate:self];
                });
            }];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self actionSheetWithTitle:@"Select Difficulty" atRow:indexPath.row
                        withDefaultRow:2 andDelegate:self.difficultyDelegate];
        }
        else if (indexPath.row == 1) {
            [self actionSheetWithTitle:@"Select Duration" atRow:indexPath.row
                        withDefaultRow:0 andDelegate:self.countDownDelegate];
        }
        else if (indexPath.row == 2) {
            [self actionSheetWithTitle:@"Select Originality" atRow:indexPath.row
                        withDefaultRow:1 andDelegate:self.originalityDelegate];
        }
    }
    else if (indexPath.section == 2) {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (self.alchool) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        self.alchool = !self.alchool;
        
    }
}

#pragma mark - PassIngredient Protocol


- (void) passIngredients:(NSMutableArray*) ingredients
{
    self.ingredients = ingredients;
}




@end
