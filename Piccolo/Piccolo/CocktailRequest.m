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

@implementation CocktailRequest

+ (void) getCocktailListAtUrl: (NSString*) url OnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/%@", SERVER_URL, url]
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                        for (NSDictionary* cocktailDic in requestResult) {
                                            NSInteger difficulty = [[cocktailDic objectForKey:@"difficulty"] intValue];
                                            NSString * diffStr = [Tools difficultyFromInteger:difficulty];
                                            NSInteger originality = [[cocktailDic objectForKey:@"originality"] intValue];
                                            NSString * orStr = [Tools orinalityFromInteger:originality];
                                            NSMutableArray* ingredients = [[NSMutableArray alloc] init];
                                            NSDictionary* ingredientsDic = [cocktailDic objectForKey:@"ingredients"];
                                            for (NSString* ingredient in ingredientsDic) {
                                                [ingredients addObject:ingredient];
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
    [self getCocktailListAtUrl:@"favorites.json" OnCompletion:complete];
}

+ (void) getCocktailListOnCompletion:(RequestDataCompletionHandler) complete;
{
    [self getCocktailListAtUrl:@"cocktails.json" OnCompletion:complete];
}

+ (void) getCocktailOfTheDayOnCompletion:(RequestCocktailCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/cocktail_of_the_day.json", SERVER_URL]
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSInteger difficulty = [[requestResult objectForKey:@"difficulty"] intValue];
                                        NSString * diffStr = [Tools difficultyFromInteger:difficulty];
                                        NSInteger originality = [[requestResult objectForKey:@"originality"] intValue];
                                        NSString * orStr = [Tools orinalityFromInteger:originality];
                                        NSMutableArray* ingredients = [[NSMutableArray alloc] init];
                                        NSDictionary* ingredientsDic = [requestResult objectForKey:@"ingredients"];
                                        for (NSString* ingredient in ingredientsDic) {
                                            [ingredients addObject:ingredient];
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
                                        if (complete) {
                                            complete(c, cocktailError);
                                        }
                                    }];
}


@end
