//
//  TextViewController.h
//  Piccolo
//
//  Created by Irenicus on 09/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassDescription <NSObject>

- (void) passDescription:(NSString*) description;

@end

@protocol PassRecipe <NSObject>

- (void) passRecipe:(NSString*) recipe;

@end

@interface TextViewController : UIViewController

@property BOOL passRecipe;
@property BOOL passDescription;

@property (nonatomic,retain) id<PassDescription> passDescriptionDelegate;
@property (nonatomic,retain) id<PassRecipe> passRecipeDelegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end