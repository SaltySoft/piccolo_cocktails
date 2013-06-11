//
//  HomeViewController.m
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "DetailedCocktailViewController.h"
#import "Cocktail.h"
#import "CocktailRequest.h"

@interface DetailedCocktailViewController ()

@end

@implementation DetailedCocktailViewController
static BOOL isHomeView = YES;

@synthesize cocktail = _cocktail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) setAsHomeView
{
    isHomeView = YES;
}

- (void) setAsDetailedView
{
    isHomeView = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (isHomeView) {
        [CocktailRequest getCocktailOfTheDayOnCompletion:^(Cocktail* c, NSError * error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (c != nil) {
                    _cocktail = c;
                    [self setViewAttributes];
                    self.navigationItem.title = [NSString stringWithFormat:@"Today's Cocktail : %@",c.name];
                }
            });
        }];
    } else {
        [self setViewAttributes];
    }

}

- (void) setViewAttributes
{
    self.isFavorite = NO;
    NSString *favoriteStarPath = [[NSBundle mainBundle] pathForResource:@"star_full" ofType:@"png"];
    NSString *notFavoriteStarPath = [[NSBundle mainBundle] pathForResource:@"star_empty" ofType:@"png"];
    self.favoriteStar = [[UIImage alloc] initWithContentsOfFile:favoriteStarPath];
    self.notFavoriteStar = [[UIImage alloc] initWithContentsOfFile:notFavoriteStarPath];
    self.image.image = _cocktail.picture;
    self.navigationItem.title = _cocktail.name;
    [self.textView setAttributedText:[self textViewStringForRecipesAndDescription]];
    self.originalityLabel.text = [_cocktail originality];
    self.difficultyLabel.text = [_cocktail difficulty];
    self.preparationLabel.text = [NSString stringWithFormat:@"%d minutes",_cocktail.duration];
}

- (NSMutableAttributedString*) textViewStringForRecipesAndDescription
{
    NSMutableAttributedString* textViewResult = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *newLine=[[NSMutableAttributedString alloc] initWithString:@"\n"];
    
    NSMutableAttributedString *ingredientString=[[NSMutableAttributedString alloc] initWithString:@"Ingredients :\n"];
    UIColor *fontColor = [UIColor colorWithRed:255.0 green:121.0 blue:57.0 alpha:1];
    UIFont *titleFont=[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    UIFont *normalFont=[UIFont fontWithName:@"Helvetica" size:20.0f];
    
    [ingredientString addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, [ingredientString length])];
    [ingredientString addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, [ingredientString length])];
    
    [textViewResult appendAttributedString:ingredientString];
    
    for (int i = 0; i < [[_cocktail ingredients] count]; i++) {
        NSMutableAttributedString *currentIngredient = [[NSMutableAttributedString alloc]
                                                        initWithString:
                                                        [NSString stringWithFormat:@"- %@",
                                                         [[_cocktail ingredients] objectAtIndex:i]
                                                         ]];
        [currentIngredient appendAttributedString:newLine];
        [currentIngredient addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [currentIngredient length])];
        [currentIngredient addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, [currentIngredient length])];
        [textViewResult appendAttributedString:currentIngredient];
    }
    NSMutableAttributedString *recipeString=[[NSMutableAttributedString alloc] initWithString:@"\nRecipe :\n"];
    [recipeString addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, [recipeString length])];
    [recipeString addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, [recipeString length])];
    
    NSMutableAttributedString *recipeInstructions=[[NSMutableAttributedString alloc] initWithString:[_cocktail recipe]];
    [recipeInstructions addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [recipeInstructions length])];
    [recipeInstructions addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, [recipeInstructions length])];
    
    [textViewResult appendAttributedString:recipeString];
    [textViewResult appendAttributedString:recipeInstructions];
    
    NSMutableAttributedString *descriptionString=[[NSMutableAttributedString alloc] initWithString:@"\n\nDescription :\n"];
    [descriptionString addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, [descriptionString length])];
    [descriptionString addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, [descriptionString length])];
    
    NSMutableAttributedString *descriptionDetail=[[NSMutableAttributedString alloc] initWithString:[_cocktail description]];
    [descriptionDetail addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [descriptionDetail length])];
    [descriptionDetail addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0, [descriptionDetail length])];
    
    [textViewResult appendAttributedString:descriptionString];
    [textViewResult appendAttributedString:descriptionDetail];
    
    return textViewResult;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favoriteAction:(id)sender {
    if (self.isFavorite) {
        self.favoriteButton.image = self.favoriteStar;
    } else {
        self.favoriteButton.image = self.notFavoriteStar;
    }
    self.isFavorite = !self.isFavorite;
}
@end
