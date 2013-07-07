//
//  CocktailRequest.m
//  Piccolo
//
//  Created by Irenicus on 07/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "CocktailRequest.h"
#import "Cocktail.h"
#import "Tools.h"
#import "AppDelegate.h"
#import "User.h"

@implementation CocktailRequest

+ (void) getCocktailListOnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails", SERVER_URL]
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                        for (NSDictionary* cocktailDic in requestResult) {
                                            NSInteger difficulty = [[cocktailDic objectForKey:@"difficulty"] intValue];
                                            NSString * diffStr = [Tools difficultyFromInteger:difficulty];
                                            NSInteger originality = [[cocktailDic objectForKey:@"originality"] intValue];
                                            NSString * orStr = [Tools orinalityFromInteger:originality];
                                            NSMutableArray* ingredients = [[NSMutableArray alloc] init];
                                            NSDictionary* ingredientsArr = [cocktailDic objectForKey:@"ingredients"];
                                            for (NSDictionary* ingredientDic in ingredientsArr) {
                                                [ingredients addObject:[ingredientDic objectForKey:@"name"]];
                                            }
                                            Cocktail* c = [[Cocktail alloc] initWithId:[[cocktailDic objectForKey:@"id"] intValue]
                                                                            difficulty:diffStr
                                                                            originality:orStr
                                                                              duration:[[cocktailDic objectForKey:@"duration"] intValue]
                                                                               creator:[cocktailDic objectForKey:@"author"]
                                                                                  name:[cocktailDic objectForKey:@"name"]
                                                                           description:[cocktailDic objectForKey:@"description"]
                                                                                recipe:[cocktailDic objectForKey:@"recipe"]
                                                                           picture_url:[cocktailDic objectForKey:@"picture_url"]
                                                                           ingredients:ingredients];
                                            [cocktailArray addObject:c];
                                        }
                                        if (complete) {
                                            complete(cocktailArray, cocktailError);
                                        }
                                    }];
}

+ (void) getFavoritesListOnCompletion:(RequestDataCompletionHandler) complete
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger userId = appDelegate.user.id;
    NSString* token = appDelegate.token;
    NSLog(@"id %d",userId);
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/favorites?id=%d&token=%@", SERVER_URL, userId, token]
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSDictionary* cocktailsResult = [requestResult objectForKey:@"favorites"];
                                        NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                        for (NSDictionary* cocktailDic in cocktailsResult) {
                                            NSInteger difficulty = [[cocktailDic objectForKey:@"difficulty"] intValue];
                                            NSString * diffStr = [Tools difficultyFromInteger:difficulty];
                                            NSInteger originality = [[cocktailDic objectForKey:@"originality"] intValue];
                                            NSString * orStr = [Tools orinalityFromInteger:originality];
                                            NSMutableArray* ingredients = [[NSMutableArray alloc] init];
                                            NSDictionary* ingredientsArr = [cocktailDic objectForKey:@"ingredients"];
                                            for (NSDictionary* ingredientDic in ingredientsArr) {
                                                [ingredients addObject:[ingredientDic objectForKey:@"name"]];
                                            }
                                            Cocktail* c = [[Cocktail alloc] initWithId:[[cocktailDic objectForKey:@"id"] intValue]
                                                                            difficulty:diffStr
                                                                           originality:orStr
                                                                              duration:[[cocktailDic objectForKey:@"duration"] intValue]
                                                                               creator:[cocktailDic objectForKey:@"author"]
                                                                                  name:[cocktailDic objectForKey:@"name"]
                                                                           description:[cocktailDic objectForKey:@"description"]
                                                                                recipe:[cocktailDic objectForKey:@"recipe"]
                                                                           picture_url:[cocktailDic objectForKey:@"picture_url"]
                                                                           ingredients:ingredients];
                                            [cocktailArray addObject:c];
                                        }
                                        if (complete) {
                                            complete(cocktailArray, cocktailError);
                                        }
                                    }];
}


+ (void) getCocktailOfTheDayOnCompletion:(RequestCocktailCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails/Random", SERVER_URL]
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSInteger difficulty = [[requestResult objectForKey:@"difficulty"] intValue];
                                        NSString * diffStr = [Tools difficultyFromInteger:difficulty];
                                        NSInteger originality = [[requestResult objectForKey:@"originality"] intValue];
                                        NSString * orStr = [Tools orinalityFromInteger:originality];
                                        NSMutableArray* ingredients = [[NSMutableArray alloc] init];
                                        NSDictionary* ingredientsArr = [requestResult objectForKey:@"ingredients"];
                                        for (NSDictionary* ingredientDic in ingredientsArr) {
                                            [ingredients addObject:[ingredientDic objectForKey:@"name"]];
                                        }
                                        Cocktail* c = [[Cocktail alloc] initWithId:[[requestResult objectForKey:@"id"] intValue]
                                                                        difficulty:diffStr
                                                                       originality:orStr
                                                                          duration:[[requestResult objectForKey:@"duration"] intValue]
                                                                           creator:[requestResult objectForKey:@"author"]
                                                                              name:[requestResult objectForKey:@"name"]
                                                                       description:[requestResult objectForKey:@"description"]
                                                                            recipe:[requestResult objectForKey:@"recipe"]
                                                                       picture_url:[requestResult objectForKey:@"picture_url"]
                                                                       ingredients:ingredients];
                                        if (complete && cocktailError == nil) {
                                            complete(c, cocktailError);
                                        } else {
                                            complete(nil, cocktailError);
                                        }
                                    }];
}

+ (void) addFavorite:(NSInteger) cocktailId onCompletion:(RequestCocktailCompletionHandler) complete
{
    
}

+ (void) removeFavorite:(NSInteger) cocktailId onCompletion:(RequestCocktailCompletionHandler) complete
{
    
}

+ (void) cocktailsByIngredients:(NSDictionary*) ingredients OnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails/byIngredients", SERVER_URL]
                                    onCompletion:^(NSData *data, NSError *cocktailError){
                                        
     }];
}

@end
