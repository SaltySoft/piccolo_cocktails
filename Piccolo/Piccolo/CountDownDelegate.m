//
//  CountDownDelegate.m
//  Piccolo
//
//  Created by Irenicus on 09/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "CountDownDelegate.h"

@implementation CountDownDelegate

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        self.minutes = [[NSMutableArray alloc] init];
        self.minutesStr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 60; i++) {
            [self.minutesStr addObject:[NSString stringWithFormat:@"%d minutes", i]];
            [self.minutes addObject:[NSString stringWithFormat:@"%d", i]];
        }
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
    return self.minutes.count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSString *text = [self.minutesStr objectAtIndex:row];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
    mutParaStyle.alignment = NSTextAlignmentCenter;
    [as addAttribute:NSParagraphStyleAttributeName value:mutParaStyle range:NSMakeRange(0,[text length])];
    return as;
}
    
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_delegate setCountDown:[[self.minutes objectAtIndex:self.selectedRow] intValue]
         andCountDownString:[self.minutesStr objectAtIndex:self.selectedRow]];
}

@end
