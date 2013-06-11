//
//  IngredientRequest.h
//  Piccolo
//
//  Created by Irenicus on 09/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHandler.h"

@interface IngredientRequest : NSObject

+ (void) getIngredientListOnCompletion:(RequestDataCompletionHandler) complete;

@end
