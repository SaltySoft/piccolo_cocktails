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

+ (void) postImageAsynchronousRequestToPath:(NSString*)path Image: (UIImage*) image onCompletion:(RequestCompletionHandler) complete
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]
                                                                cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
                                                            timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // file
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n"]
                          dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
                               if (complete && data != nil) {
                                   complete(data, error);
                               }
                           }];
}

+ (Cocktail*) parseCocktailDic:(NSDictionary*) cocktailDic
{
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
                                     author_id:[[cocktailDic objectForKey:@"author_id"] intValue]
                                          name:[cocktailDic objectForKey:@"name"]
                                   description:[cocktailDic objectForKey:@"description"]
                                        recipe:[cocktailDic objectForKey:@"recipe"]
                                   picture_url:[cocktailDic objectForKey:@"picture_url"]
                                   ingredients:ingredients];
    return c;
}

+ (void) getCocktailListFromPath:(NSString*)path OnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:path
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                        for (NSDictionary* cocktailDic in requestResult) {
                                            Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
                                            [cocktailArray addObject:c];
                                        }
                                        if (complete) {
                                            complete(cocktailArray, cocktailError);
                                        }
                                    }];
}

+ (void) getCocktailListOnCompletion:(RequestDataCompletionHandler) complete
{
    [CocktailRequest getCocktailListFromPath:[NSString stringWithFormat:@"%s/Cocktails", SERVER_URL] OnCompletion:complete];
}

+ (void) getFavoritesListOnCompletion:(RequestDataCompletionHandler) complete
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger userId = appDelegate.user.id;
    NSString* token = appDelegate.token;
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/favorites?id=%d&token=%@", SERVER_URL, userId, token]
                                    onCompletion:^(NSData * data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSDictionary* cocktailsResult = [requestResult objectForKey:@"favorites"];
                                        NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                        for (NSDictionary* cocktailDic in cocktailsResult) {
                                            Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
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
                                        Cocktail* c = [CocktailRequest parseCocktailDic:requestResult];
                                        if (complete && cocktailError == nil) {
                                            complete(c, cocktailError);
                                        } else {
                                            complete(nil, cocktailError);
                                        }
                                    }];
}

+ (void) cocktailsByIngredients:(NSDictionary*) ingredients OnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails/byIngredients", SERVER_URL] withParams:ingredients
                                     onCompletion:^(NSData *data, NSError *cocktailError){
                                        NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                        NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                        for (NSDictionary* cocktailDic in requestResult) {
                                            Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
                                            [cocktailArray addObject:c];
                                        }
                                        if (complete) {
                                            complete(cocktailArray, cocktailError);
                                        }
     }];
}


+ (void) cocktailsFilter:(NSDictionary*) filterDic OnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails/filter", SERVER_URL] withParams:filterDic
                                     onCompletion:^(NSData *data, NSError *cocktailError){
                                         NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                         NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                         for (NSDictionary* cocktailDic in requestResult) {
                                             Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
                                             [cocktailArray addObject:c];
                                         }
                                         if (complete) {
                                             complete(cocktailArray, cocktailError);
                                         }
                                     }];
}


+ (void) addCocktail:(NSDictionary*) cocktailDic OnCompletion:(RequestCocktailCompletionHandlerWithErrors) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails/create", SERVER_URL]
                                        withParams:cocktailDic
                                     onCompletion:^(NSData *data, NSError *cocktailError){
                                         NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                         NSDictionary* cocktailResult = [requestResult objectForKey:@"cocktail"];
                                         NSString* token = [requestResult objectForKey:@"token"];
                                         if (cocktailResult != nil && token != nil) {
                                             Cocktail* c = [CocktailRequest parseCocktailDic:cocktailResult];
                                             complete(c, token, nil);
                                         } else {
                                             NSString* errorMsg = [requestResult objectForKey:@"error"];
                                             complete (nil, nil, errorMsg);
                                         }
                                     }];
}

+ (void) deleteCocktail:(NSInteger) cocktailId OnCompletion:(RequestDataCompletionHandler) complete
{
    NSMutableDictionary* cocktailDic = [[NSMutableDictionary alloc] init];
    [cocktailDic setValue:[NSString stringWithFormat:@"%d",cocktailId] forKey:@"author_id"];
    
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Cocktails/destroy", SERVER_URL]
                                       withParams:cocktailDic
                                     onCompletion:^(NSData *data, NSError *cocktailError){
                                         NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&cocktailError];
                                         NSMutableArray* cocktailArray = [[NSMutableArray alloc] init];
                                         for (NSDictionary* cocktailDic in requestResult) {
                                             Cocktail* c = [CocktailRequest parseCocktailDic:cocktailDic];
                                             [cocktailArray addObject:c];
                                         }
                                         if (complete) {
                                             complete(cocktailArray, cocktailError);
                                         }
                                     }];
}

@end
