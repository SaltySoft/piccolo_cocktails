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
@property (nonatomic, retain) NSString* password;
@property BOOL admin;

@property (nonatomic, retain) NSMutableArray* favorites;

@end
