//
//  AddCocktailTableViewController.m
//  Piccolo
//
//  Created by Irenicus on 08/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "AddCocktailTableViewController.h"

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

- (IBAction)cancelAction:(id)sender {
    [_delegate addCocktailDidCancel:self];
}

- (IBAction)doneAction:(id)sender {
    [_delegate addCocktailDidCancel:self];
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
    [picker dismissModalViewControllerAnimated:YES];
}

@end
