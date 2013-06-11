//
//  Ingredient.m
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize id = _id;
@synthesize name = _name;

- (id)initWithId:(NSInteger) id andName: (NSString*) name
{
    self = [super init];
    if (self) {
        _name = name;
        _id = id;
    }
    return self;
}

@end
