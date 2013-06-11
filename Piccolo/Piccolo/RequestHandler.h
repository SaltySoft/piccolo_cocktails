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
typedef void (^RequestDataCompletionHandler)(NSArray*, NSError* );


@interface RequestHandler : NSObject

+ (void) getAsynchronousRequestToPath:(NSString*)path onCompletion:(RequestCompletionHandler) complete;

@end
