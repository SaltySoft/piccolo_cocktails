//
//  OriginalityDataSource.h
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassOriginality <NSObject>

- (void) setOriginality: (NSString*) originality;


@end

@interface OriginalityDelegate : NSObject <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

@property (nonatomic, retain) NSArray* originalities;
@property (nonatomic, retain) id<PassOriginality> delegate;
@property NSInteger selectedRow;

@end
