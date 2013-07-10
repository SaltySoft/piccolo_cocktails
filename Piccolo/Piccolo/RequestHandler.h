//
//  RequestHandler.h
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"


typedef void (^RequestCompletionHandler)(NSData*, NSError* );
typedef void (^RequestStringCompletionHandler)(NSString*, NSError* );
typedef void (^RequestDataCompletionHandler)(NSArray*, NSError* );
typedef void (^RequestArrayCompletionHandlerWithErrors)(NSArray*,NSString*, NSString*);



@interface RequestHandler : NSObject

+ (void) getAsynchronousRequestToPath:(NSString*)path onCompletion:(RequestCompletionHandler) complete;
+ (void) postAsynchronousRequestToPath:(NSString*)path withParams: (NSDictionary*) params onCompletion:(RequestCompletionHandler) complete;
+ (void) putAsynchronousRequestToPath:(NSString*)path withParams: (NSDictionary*) params onCompletion:(RequestCompletionHandler) complete;
+ (void) deleteAsynchronousRequestToPath:(NSString*)path onCompletion:(RequestCompletionHandler) complete;



@end
