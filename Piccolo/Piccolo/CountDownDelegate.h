//
//  CountDownDelegate.h
//  Piccolo
//
//  Created by Irenicus on 09/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassCountDown <NSObject>
 
- (void) setCountDown: (NSInteger) countDown andCountDownString: (NSString*) countDownString;

@end

@interface CountDownDelegate : NSObject <UIPickerViewDataSource, UIPickerViewDelegate , UIActionSheetDelegate>

@property (nonatomic, retain) NSMutableArray* minutesStr;
@property (nonatomic, retain) NSMutableArray* minutes;

@property (nonatomic, retain) id<PassCountDown> delegate;
@property NSInteger selectedRow;

@end
