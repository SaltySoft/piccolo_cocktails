//
//  RequestHandler.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "RequestHandler.h"

@implementation RequestHandler

+ (void) getAsynchronousRequestToPath:(NSString*)path onCompletion:(RequestCompletionHandler) complete
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]
                                                  cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
                                              timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
                               if (complete && data != nil) {
                                   complete(data, error);
                               }
                           }];
}

@end
