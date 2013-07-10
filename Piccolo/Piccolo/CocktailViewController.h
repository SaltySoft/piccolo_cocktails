//
//  CocktailViewController.h
//  Piccolo
//
//  Created by Irenicus on 06/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cocktail;
@interface CocktailViewController : UIViewController


@property (nonatomic,retain) Cocktail* cocktail;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) UIImage* favoriteStar;
@property (strong, nonatomic) UIImage* notFavoriteStar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *preparationLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalityLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property BOOL isFavorite;

@property BOOL canRemove;


- (void) favoriteAction;

- (void) setViewAttributes;

- (void) setTitle:(NSString*) title;

- (IBAction)deleteAction:(id)sender;

@end
