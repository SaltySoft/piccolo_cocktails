//
//  User.m
//  Piccolo
//
//  Created by Irenicus on 05/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize id = _id, username = _username, email = _email, hash = _hash, admin = _admin;

- (id)initWithId:(NSInteger)id
        username:(NSString *)username
           email:(NSString *)email
           hash:(NSString *)hash
          admin:(BOOL)admin
{
    self = [super init];
    if (self) {
        _id = id;
        _username = username;
        _email = email;
        _hash = hash;
        _admin = admin;
    }
    return self;
}

@end
