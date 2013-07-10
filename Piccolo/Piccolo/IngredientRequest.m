//
//  IngredientRequest.m
//  Piccolo
//
//  Created by Irenicus on 09/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "IngredientRequest.h"
#import "Ingredient.h"


@implementation IngredientRequest

+ (void) getIngredientListOnCompletion:(RequestDataCompletionHandler) complete
{
    [RequestHandler getAsynchronousRequestToPath:[NSString stringWithFormat:@"%s/Ingredients", SERVER_URL]
                                    onCompletion:^(NSData * data, NSError *ingredientError)
    {
        if (data) {
            NSDictionary* requestResult = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingMutableLeaves
                                                                            error:&ingredientError];
            NSMutableArray* ingredientArray = [[NSMutableArray alloc] init];
            for (NSDictionary* ingredientDic in requestResult) {
                Ingredient* ing = [[Ingredient alloc]
                                   initWithId:[[ingredientDic objectForKey:@"id"] intValue]
                                   andName:[ingredientDic objectForKey:@"name"]];
                [ingredientArray addObject:ing];
            }
            if (complete) {
                complete(ingredientArray, ingredientError);
            }
        } else {
            complete(nil, ingredientError);
        }
    }];

}

@end
