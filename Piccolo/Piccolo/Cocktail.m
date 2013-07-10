//
//  Cocktail.m
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "Cocktail.h"

@implementation Cocktail

@synthesize id = _id;

@synthesize originality = _originality;
@synthesize difficulty = _difficulty;
@synthesize duration = _duration;
@synthesize author_id = _author_id;
@synthesize creator = _creator;

@synthesize name = _name;
@synthesize description = _description;
@synthesize recipe = _recipe;

@synthesize picture_url = _picture_url;
@synthesize picture = _picture;
@synthesize ingredients = _ingredients;

- (id)initWithId:(NSInteger)id
    difficulty:(NSString *)difficulty
    originality:(NSString *)originality
    duration:(NSInteger)duration
    creator:(NSString*) creator
    author_id:(NSInteger) author_id
    name:(NSString *)name
    description:(NSString *)description
    recipe:(NSString *)recipe
    picture_url:(NSString *)picture_url
    ingredients:(NSArray *) ingredients
{
    self = [super init];
    if (self) {
        _id = id;
        _difficulty = difficulty;
        _originality = originality;
        _duration = duration;
        _author_id = author_id;
        _creator = creator;
        _name = name;
        _description = description;
        _recipe = recipe;
        _picture_url = [NSURL URLWithString:picture_url];
        NSData *data = [NSData dataWithContentsOfURL:_picture_url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        _picture = img;
        _ingredients = ingredients;
    }

    return self;
}

@end
