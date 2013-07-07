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

@interface CocktailRequest : NSObject

+ (void) getCocktailOfTheDayOnCompletion:(RequestCocktailCompletionHandler) complete;

+ (void) getFavoritesListOnCompletion:(RequestDataCompletionHandler) complete;

+ (void) getCocktailListOnCompletion:(RequestDataCompletionHandler) complete;

+ (void) cocktailsByIngredients:(NSDictionary*) ingredients OnCompletion:(RequestDataCompletionHandler) complete;


@end
