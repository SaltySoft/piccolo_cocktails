//
//  Tools.m
//  Piccolo
//
//  Created by Irenicus on 09/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSString*) stringMinutesFromTimeInterval: (NSTimeInterval) timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}

+ (NSString*) orinalityFromInteger: (NSInteger) integer
{
    switch (integer) {
        case 0:
            return @"Commun";
        case 1:
            return @"Classic";
        case 3:
            return @"Famous";
        case 4:
            return @"Original";
        default:
            return @"Creative";
    }
}

+ (NSString*) difficultyFromInteger: (NSInteger) integer
{
    switch (integer) {
        case 0:
            return @"Very easy";
        case 1:
            return @"Easy";
        case 3:
            return @"Hard";
        case 4:
            return @"Very hard";
        default:
            return @"Medium";
    }
}

@end
