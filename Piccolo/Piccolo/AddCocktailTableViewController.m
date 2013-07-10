//
//  AddCocktailTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 08/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "AddCocktailTableViewController.h"

#import "CocktailRequest.h"

#import "AppDelegate.h"

#import "User.h"
#import "Ingredient.h"

@interface AddCocktailTableViewController ()

@end

@implementation AddCocktailTableViewController

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
    [self.difficultyDelegate setDelegate:self];
    [self.originalityDelegate setDelegate:self];
    [self.countDownDelegate setDelegate:self];
    self.originalityInt = 0;
    self.difficultyInt = 0;
    self.recipe = @"";
    self.description = @"";
    self.url = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            [self selectPhotos];
        }
    }
    else if (indexPath.section == 3) {
        UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TextViewController *ct = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TextController"];
        if (indexPath.row == 0) {
            ct.passRecipeDelegate = self;
            ct.passRecipe = YES;
            ct.passDescription = NO;
            [self.navigationController pushViewController:ct animated:YES];
        }
        else if (indexPath.row == 1)
        {
            ct.passDescriptionDelegate = self;
            ct.passDescription = YES;
            ct.passRecipe = NO;
            [self.navigationController pushViewController:ct animated:YES];
        }
    }
}

#pragma mark - Protocols

- (void) setOriginality: (NSString*) originality andOriginalityInt: (NSInteger) originalityInt
{
    self.originalityField.text = originality;
    self.originalityInt = originalityInt;
}

- (void) setDifficultyString: (NSString*) difficulty andDifficultyInt: (NSInteger) difficultyInt;
{
    self.difficultyField.text = difficulty;
    self.difficultyInt = difficultyInt;
}


- (void) setCountDown: (NSInteger) countDown andCountDownString: (NSString*) countDownString
{
    self.preparationField.text = countDownString;
    self.countDown = countDown;
}

- (IBAction)cancelAction:(id)sender {
    [_delegate addCocktailDidCancel:self];
}

- (IBAction)doneAction:(id)sender {
    if (self.nameField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cocktail name error" message:@"You must give a name to your cocktail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    User* user = [appDelegate user];
    NSString* token = appDelegate.token;

    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.nameField.text forKey:@"name"];
    [dic setValue:[NSString stringWithFormat:@"%d",self.difficultyInt] forKey:@"difficulty"];
    [dic setValue:[NSString stringWithFormat:@"%d",self.originalityInt] forKey:@"originality"];
    [dic setValue:[NSString stringWithFormat:@"%d",[super countDown]] forKey:@"duration"];
    [dic setValue:user.username forKey:@"author"];
    [dic setValue:self.description forKey:@"description"];
    [dic setValue:self.recipe forKey:@"recipe"];
    [dic setValue:self.url forKey:@"picture_url"];
    [dic setValue:[NSString stringWithFormat:@"%d", user.id] forKey:@"author"];

    [dic setValue:[NSString stringWithFormat:@"%d",[super alchool]]forKey:@"alchohol"];
    [dic setValue:token forKey:@"token"];
    NSLog(@"%@",[super ingredients]);
    if ([[super ingredients] count] != 0) {
        NSMutableArray* ingredientIds = [[NSMutableArray alloc] init];
        for (Ingredient* ing in [super ingredients]) {
            [ingredientIds addObject:[NSString stringWithFormat:@"%d",ing.id]];
        }
        [dic setValue:ingredientIds forKey:@"ingredients_ids"];
    }


    
    
    [CocktailRequest addCocktail:dic OnCompletion:^(Cocktail* c, NSString* token, NSString* error){
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (c != nil && token != nil) {
                [_delegate addCocktailDidSuccess:self cocktail:c];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The cocktail was not added" message:error
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        });
    }];
}


- (void)selectPhotos
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image = image;
    
    [CocktailRequest postImageAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/cocktails/addPicture", SERVER_URL]
                                                  Image:image
                                           onCompletion:^(NSData* data, NSError* error){
                                               dispatch_async(dispatch_get_main_queue(), ^(){
                                                   if (error == nil) {
                                                       NSError* cocktailError;
                                                       NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                                       NSString* url = [requestResult objectForKey:@"url_picture"];
                                                       self.url = [NSString stringWithFormat:@"%s%@", SERVER_URL,url];
                                                       [picker dismissModalViewControllerAnimated:YES];
                                                   } else {
                                                       NSLog(@"error : %@", error);
                                                   }
                                               });
    }];
}

- (void) passDescription:(NSString*) description
{
    self.description = description;
}

- (void) passRecipe:(NSString*) recipe
{
    self.recipe = recipe;
}

@end
