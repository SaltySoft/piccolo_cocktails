//
//  Ingredient.h
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property NSInteger id;
@property (nonatomic, retain) NSString* name;

- (id)initWithId:(NSInteger) id andName: (NSString*) name;

@end
