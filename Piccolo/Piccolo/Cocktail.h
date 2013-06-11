//
//  Cocktail.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface Cocktail : NSObject

@property NSInteger id;
@property (nonatomic, retain) NSString* difficulty;
@property (nonatomic, retain) NSString* originality;

@property NSInteger duration;

@property (nonatomic, retain) NSString* creator;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* recipe;
@property (nonatomic, retain) NSURL* picture_url;
@property (nonatomic, retain) UIImage* picture;

@property (nonatomic, retain) NSArray* ingredients;

- (id)initWithId:(NSInteger)id
     difficulty:(NSString *)difficulty
     originality:(NSString *)originality
       duration:(NSInteger)duration
        creator:(NSString *)creator
          name:(NSString *)name
    description:(NSString *)description
         recipe:(NSString *)recipe
    picture_url:(NSString *)picture_url
    ingredients:(NSArray *) ingredients;

@end