//
//  UserRequest.m
//  Piccolo
//
//  Created by Irenicus on 07/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "UserRequest.h"
#import "AppDelegate.h"
#import "CocktailRequest.h"

@implementation UserRequest

+ (User*) parseCocktailDic:(NSDictionary*) userDicRes
{
    User* u = [[User alloc] initWithId:[[userDicRes objectForKey:@"id"] integerValue]
                              username:[userDicRes objectForKey:@"name"]
                                 email:[userDicRes objectForKey:@"email"]
                                  hash:[userDicRes objectForKey:@"hash"]
                                 admin:[[userDicRes objectForKey:@"admin"] integerValue]];
    return u;
}


+ (void) createUserWithUser:(NSDictionary*)userDic onCompletion:(RequestUserCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/create", SERVER_URL]
                                       withParams:userDic onCompletion:^(NSData* data, NSError* error)
    {
                                           if (data) {
                                               NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                               NSDictionary* userDicRes = [requestResult objectForKey:@"user"];
                                               NSString* token = [requestResult objectForKey:@"token"];
                                               if (userDicRes != nil && token != nil) {
                                                   User* u = [UserRequest parseCocktailDic:userDicRes];
                                                   complete (u,token, nil);
                                               } else {
                                                   NSString* errorMsg = [requestResult objectForKey:@"error"];
                                                   complete (nil, nil, errorMsg);
                                               }
                                           } else {
                                               complete (nil, nil, @"Connection failed");
                                           }
    }];
}


+ (void) loginUserWithUser:(NSDictionary*)userDic onCompletion:(RequestUserCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/login", SERVER_URL]
                                       withParams:userDic onCompletion:^(NSData* data, NSError* error)
    {
                                           if (data) {
                                               NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                               NSDictionary* userDicRes = [requestResult objectForKey:@"user"];
                                               NSString* token = [requestResult objectForKey:@"token"];
                                               if (userDicRes != nil && token != nil) {
                                                   User* u = [UserRequest parseCocktailDic:userDicRes];
                                                   complete (u,token, nil);
                                               } else {
                                                   NSString* errorMsg = [requestResult objectForKey:@"error"];
                                                   complete (nil, nil, errorMsg);
                                               }
                                           } else {
                                               complete (nil, nil, @"Connection failed");

                                           }

    }];
}

+ (void) logoutUserOnCompletion: (RequestStringCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/logout", SERVER_URL]
                                       withParams:[[NSDictionary alloc] init] onCompletion:^(NSData* data, NSError* error)
    {
        if (data) {
            NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSString* response = [requestResult objectForKey:@"message"];
            if (error == nil) {
                complete(response,nil);
            } else {
                complete(response,error);
            }
        } else {
            complete(nil,error);
        }

    }];
}



+ (void) addFavoriteforCocktailId: (NSInteger) cocktail_id OnCompletion:(RequestArrayCompletionHandlerWithErrors) complete
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger user_id = appDelegate.user.id;
    NSString* token = appDelegate.token;
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%d", user_id] forKey:@"user_id"];
    [dic setObject:[NSString stringWithFormat:@"%d", cocktail_id] forKey:@"cocktail_id"];
    [dic setObject:token forKey:@"token"];
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/addFavorite", SERVER_URL]
                                       withParams:dic
                                     onCompletion:^(NSData* data, NSError* cocktailError)
    {
        if (data) {
            NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
            NSDictionary* cocktailsResult = [requestResult objectForKey:@"favorites"];
            NSString* token = [requestResult objectForKey:@"token"];
            if (cocktailsResult != nil && token != nil) {
                NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                for (NSDictionary* cocktailDic in cocktailsResult) {
                    Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
                    [cocktailArray addObject:c];
                }
                complete(cocktailArray, token, nil);
            } else {
                NSString* errorMsg = [requestResult objectForKey:@"error"];
                complete (nil, nil, errorMsg);
            }
        } else {
            complete (nil, nil, @"Connection failed");
        }
    }];
}

+ (void) removeFavoriteforCocktailId: (NSInteger) cocktail_id OnCompletion:(RequestArrayCompletionHandlerWithErrors) complete
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger user_id = appDelegate.user.id;
    NSString* token = appDelegate.token;
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%d", user_id] forKey:@"user_id"];
    [dic setObject:[NSString stringWithFormat:@"%d", cocktail_id] forKey:@"cocktail_id"];
    [dic setObject:token forKey:@"token"];
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/removeFavorite", SERVER_URL]
                                       withParams:dic
                                     onCompletion:^(NSData* data, NSError* cocktailError)
    {
        if (data) {
            NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
            NSDictionary* cocktailsResult = [requestResult objectForKey:@"favorites"];
            NSString* token = [requestResult objectForKey:@"token"];
            if (cocktailsResult != nil && token != nil) {
                NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                for (NSDictionary* cocktailDic in cocktailsResult) {
                    Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
                    [cocktailArray addObject:c];
                }
                complete(cocktailArray, token, nil);
            } else {
                NSString* errorMsg = [requestResult objectForKey:@"error"];
                complete (nil, nil, errorMsg);
            }
        } else {
            complete (nil, nil, @"Connection failed");
        }
    }];
}

@end
