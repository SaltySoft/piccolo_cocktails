//
//  FilterTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "FilterTableViewController.h"
#import "Tools.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController
@synthesize delegate = _delegate;


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
    [self.difficultyDelegate setDelegate:self];
    [self.originalityDelegate setDelegate:self];
    [self.countDownDelegate setDelegate:self];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) addNewCocktailController
{
    self.navigationItem.title = @"Add a Cocktail";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonSystemItemCancel
                                                                            target:self
                                                                            action:@selector(cancelCocktailInsertion)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(submitCocktail)];
}

- (void) cancelCocktailInsertion
{
    [_delegate addCocktailDidCancel:self];
}

- (void) submitCocktail
{
    NSLog(@"submitRequest here !");
    [_delegate addCocktailDidSuccess:self];
}


- (void) filterCocktailController
{
    self.navigationItem.title = @"Filter";
}


- (void) hideKeyboard {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet setBounds:CGRectMake(0,0, 320, 411)];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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



#pragma mark - Protocols

- (void) setOriginality: (NSString*) originality
{
    self.originalityField.text = originality;
}

- (void) setDifficulty: (NSString*) difficulty
{
    self.difficultyField.text = difficulty;
}


- (void) setCountDown: (NSInteger) countDown andCountDownString: (NSString*) countDownString
{
    self.preparationField.text = countDownString;
    self.countDown = countDown;
}

@end
