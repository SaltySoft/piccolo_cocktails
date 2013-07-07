//
//  User.h
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSInteger id;

@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* hash;
@property BOOL admin;

- (id)initWithId:(NSInteger)id
        username:(NSString *)username
           email:(NSString *)email
            hash:(NSString *)hash
           admin:(BOOL)admin;
@end
