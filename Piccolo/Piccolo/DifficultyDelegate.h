//
//  difficultyDataSource.h
//  Piccolo
//
//  Created by Irenicus on 06/06/13.
//  Copyright (c) 2013 Salty Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassDifficulty <NSObject>

- (void) setDifficultyString: (NSString*) difficulty andDifficultyInt: (NSInteger) difficultyInt;

@end


@interface DifficultyDelegate : NSObject <UIPickerViewDataSource, UIPickerViewDelegate , UIActionSheetDelegate>

@property (nonatomic, retain) NSArray* difficulties;
@property (nonatomic, retain) id<PassDifficulty> delegate;
@property NSInteger selectedRow;

@end
