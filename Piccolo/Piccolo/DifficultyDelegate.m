//
//  difficultyDataSource.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "DifficultyDelegate.h"

@implementation DifficultyDelegate

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        self.difficulties = [[NSArray alloc] initWithObjects:@"Very Easy", @"Easy", @"Medium", @"Hard", @"Very Hard", nil];
        self.selectedRow = 0;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.difficulties.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.difficulties objectAtIndex:row];
}
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_delegate setDifficulty:[self.difficulties objectAtIndex:self.selectedRow]];
}


@end
