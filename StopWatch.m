//
//  StopWatch.m
//  StopWatch
//
//  Created by Nathan Cope on 8/10/14.
//  Copyright (c) 2014 Nathan Cope. All rights reserved.
//

#import "StopWatch.h"

@interface StopWatch () {
    NSTimer *_myTimer;
    NSDate *_currentDate;
}

@end

@implementation StopWatch


- (void) stopTimer{
    
    if(_myTimer){
        [_myTimer invalidate];
        _myTimer = nil;
 
        //store an end date
        _endDate = [NSDate date];
        
        NSLog(@"End date: %@", _endDate);
        [self updateStopWatch];
        
        //[self.lapButton setEnabled:NO];
    }
}

- (void) updateTime{
    
    [self updateStopWatch];
    
}

- (NSTimeInterval)duration {
    NSTimeInterval elapsedSeconds = 0;
    
    if(_currentDate && _startDate){
        elapsedSeconds = [_currentDate timeIntervalSinceDate:_startDate];
    }
    return elapsedSeconds;
}

- (void) startTimer{
    
    //only if nil
    if(!_myTimer){
        
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(updateStopWatch) userInfo:nil repeats:YES];
        
        //store a start date
        if(!_startDate){
            _startDate = [NSDate date];
        } else {
            // resume
            NSTimeInterval duration = [_endDate timeIntervalSinceDate:_startDate];
            _startDate = [NSDate dateWithTimeInterval:-duration sinceDate:[NSDate date]];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat: @"MMMM, YYYY - HH:mm:ss.SSS"];
        
        NSString *startDateString = [formatter stringFromDate:_startDate];
        
        NSLog(@"Start date: %@", startDateString);
        
    } else {
        
        //[self stopTimer];
        
        //[self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}


- (void) resetTimer{
    
    [self stopTimer];

    _startDate = nil;
    _endDate = nil;
    _currentDate = nil;
    
    [self updateStopWatch];

}

- (void) updateStopWatch {
    
    _currentDate = [NSDate date];

    [self.delegate timeUpdated:self];
    
}

- (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval{
    
    //get date from elapsed seconds using interval from start of computer time (January 1, 1970)
    NSDate *dateFromElapsedSeconds = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //init timezone
    NSTimeZone *timeZone = [[NSTimeZone alloc]init];
    
    //set timezone to universal
    timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    //init nsdateformatter
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    
    //format date
    [formattedDate setDateFormat:@"HH:mm:ss.SSS"];
    
    //set time zone
    [formattedDate setTimeZone:timeZone];
    
    return [formattedDate stringFromDate:dateFromElapsedSeconds];
}

@end
