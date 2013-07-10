//
//  UserRequest.h
//  Piccolo
//
//  Created by Irenicus on 07/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"
#import "RequestHandler.h"
#import "User.h"

typedef void (^RequestUserCompletionHandler)(User*,NSString*, NSString*);

@interface UserRequest : NSObject

+ (void) createUserWithUser:(NSDictionary*)userDic onCompletion:(RequestUserCompletionHandler) complete;

+ (void) loginUserWithUser:(NSDictionary*)userDic onCompletion:(RequestUserCompletionHandler) complete;

+ (void) logoutUserOnCompletion: (RequestStringCompletionHandler) complete;

+ (void) addFavoriteforCocktailId: (NSInteger) cocktail_id OnCompletion:(RequestArrayCompletionHandlerWithErrors) complete;

+ (void) removeFavoriteforCocktailId: (NSInteger) cocktail_id OnCompletion:(RequestArrayCompletionHandlerWithErrors) complete;


@end
