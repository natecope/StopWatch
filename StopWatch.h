//
//  StopWatch.h
//  StopWatch
//
//  Created by Nathan Cope on 8/10/14.
//  Copyright (c) 2014 Nathan Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StopWatch;

@protocol StopWatchDelegate <NSObject>
// required methods are default behavior
-(void) timeUpdated:(StopWatch *)stopWatch;
@end


@interface StopWatch : NSObject

@property (readonly,nonatomic) NSDate *startDate;
@property (readonly,nonatomic) NSDate *endDate;
@property (nonatomic, weak) id<StopWatchDelegate> delegate;

- (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval;
- (NSTimeInterval)duration;
- (void)startTimer;
- (void)stopTimer;
- (void)resetTimer;
- (void)updateTime;

@end
