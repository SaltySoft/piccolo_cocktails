//
//  AppDelegate.h
//  Piccolo
//
//  Created by Irenicus on 04/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) User* user;
@property (nonatomic, retain) NSString* token;

- (BOOL) isAuthenticated;

@end
