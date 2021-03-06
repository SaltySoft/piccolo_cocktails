//
//  CocktailRequest.h
//  Piccolo
//
//  Created by Irenicus on 07/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHandler.h"


@class Cocktail;

typedef void (^RequestCocktailCompletionHandler)(Cocktail*, NSError* );
typedef void (^RequestCocktailCompletionHandlerWithErrors)(Cocktail*,NSString*, NSString*);


@interface CocktailRequest : NSObject

+ (Cocktail*) parseCocktailDic:(NSDictionary*) cocktailDic;

+ (void) getCocktailListFromPath:(NSString*)path OnCompletion:(RequestDataCompletionHandler) complete;

+ (void) getCocktailOfTheDayOnCompletion:(RequestCocktailCompletionHandler) complete;

+ (void) getFavoritesListOnCompletion:(RequestDataCompletionHandler) complete;

+ (void) getCocktailListOnCompletion:(RequestDataCompletionHandler) complete;

+ (void) cocktailsByIngredients:(NSDictionary*) ingredients OnCompletion:(RequestDataCompletionHandler) complete;

+ (void) addCocktail:(NSDictionary*) cocktailDic OnCompletion:(RequestCocktailCompletionHandlerWithErrors) complete;

+ (void) cocktailsFilter:(NSDictionary*) filterDic OnCompletion:(RequestDataCompletionHandler) complete;

+ (void) postImageAsynchronousRequestToPath:(NSString*)path Image: (UIImage*) image onCompletion:(RequestCompletionHandler) complete;

+ (void) deleteCocktail:(NSInteger) cocktailId OnCompletion:(RequestDataCompletionHandler) complete;


@end


