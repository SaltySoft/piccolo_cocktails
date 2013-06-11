//
//  Tools.h
//  Piccolo
//
//  Created by Irenicus on 09/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+ (NSString*) stringMinutesFromTimeInterval: (NSTimeInterval) timeInterval;

+ (NSString*) difficultyFromInteger: (NSInteger) integer;

+ (NSString*) orinalityFromInteger: (NSInteger) integer;

@end
