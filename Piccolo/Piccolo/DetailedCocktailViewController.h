//
//  HomeViewController.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cocktail;
@interface DetailedCocktailViewController : UIViewController

@property (nonatomic,retain) Cocktail* cocktail;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;

@property (strong, nonatomic) UIImage* favoriteStar;
@property (strong, nonatomic) UIImage* notFavoriteStar;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *preparationLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalityLabel;

@property BOOL isFavorite;

- (IBAction)favoriteAction:(id)sender;

- (void) setAsHomeView;

- (void) setAsDetailedView;

@end
