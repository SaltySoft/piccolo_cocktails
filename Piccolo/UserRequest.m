//
//  UserRequest.m
//  Piccolo
//
//  Created by Irenicus on 07/07/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "UserRequest.h"

@implementation UserRequest

+ (void) createUserWithUser:(NSDictionary*)userDic onCompletion:(RequestUserCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/create", SERVER_URL]
                                       withParams:userDic onCompletion:^(NSData* data, NSError* error){
                                           NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                           NSDictionary* userDicRes = [requestResult objectForKey:@"user"];
                                           NSString* token = [requestResult objectForKey:@"token"];
                                           if (userDicRes != nil && token != nil) {
                                               User* u = [[User alloc] initWithId:[[userDicRes objectForKey:@"id"] integerValue]
                                                                         username:[userDicRes objectForKey:@"name"]
                                                                            email:[userDicRes objectForKey:@"email"]
                                                                             hash:[userDicRes objectForKey:@"hash"]
                                                                            admin:[[userDicRes objectForKey:@"admin"] integerValue]];
                                               complete (u,token, nil);
                                           } else {
                                               NSString* errorMsg = [requestResult objectForKey:@"error"];
                                               complete (nil, nil, errorMsg);
                                           }
    }];
}

+ (void) loginUserWithUser:(NSDictionary*)userDic onCompletion:(RequestUserCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/login", SERVER_URL]
                                       withParams:userDic onCompletion:^(NSData* data, NSError* error){
                                           NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                           NSDictionary* userDicRes = [requestResult objectForKey:@"user"];
                                           NSString* token = [requestResult objectForKey:@"token"];
                                           if (userDicRes != nil && token != nil) {
                                               User* u = [[User alloc] initWithId:[[userDicRes objectForKey:@"id"] integerValue]
                                                                         username:[userDicRes objectForKey:@"name"]
                                                                            email:[userDicRes objectForKey:@"email"]
                                                                             hash:[userDicRes objectForKey:@"hash"]
                                                                            admin:[[userDicRes objectForKey:@"admin"] integerValue]];
                                               complete (u,token, nil);
                                           } else {
                                               NSString* errorMsg = [requestResult objectForKey:@"error"];
                                               complete (nil, nil, errorMsg);
                                           }
    }];
}

+ (void) logoutUserOnCompletion: (RequestStringCompletionHandler) complete
{
    [RequestHandler postAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Users/logout", SERVER_URL]
                                       withParams:[[NSDictionary alloc] init] onCompletion:^(NSData* data, NSError* error){
                                           NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                           NSString* response = [requestResult objectForKey:@"message"];
                                           if (error == nil) {
                                               complete(response,nil);
                                           } else {
                                               complete(response,error);
                                           }
                                       }];
}

@end
