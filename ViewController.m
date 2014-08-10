//
//  ViewController.m
//  StopWatch
//
//  Created by Nathan Cope on 7/30/14.
//  Copyright (c) 2014 Nathan Cope. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    NSDate *_startDate;
    NSDate *_endDate;
    NSDate *_currentDate;
    NSTimer *_myTimer;
    
    //NSCalendar *gregorianCalendarl

    }

@property (strong, nonatomic) IBOutlet UIView *masterView;
@property (strong, nonatomic) IBOutlet UIView *uiBaseView;
@property (weak, nonatomic) IBOutlet UILabel *timerText;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;

- (IBAction)lapButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //_myTimer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateTime:(NSTimer *)timer{
    
    _currentDate = [NSDate date];

    [self updateDisplayTime];
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.uiBaseView.center = self.masterView.center;
}


- (void) stopTimer{
    
    [_myTimer invalidate];
    
    _myTimer = nil;
    
    if(_startDate){
        //store an end date
        _endDate = [NSDate date];
        
        //NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        //[formatter setDateFormat: @"MMMM, YYYY - HH:mm:ss.SSS"];
        
        //NSString *endDateString = [formatter stringFromDate:_endDate];
        
        //NSLog(@"End date: %@", endDateString);
        [self updateDisplayTime];
        
        [self.lapButton setEnabled:NO];
    }
}

- (void) startTimer{
    
    //only if nil
    if(!_myTimer){
        
        _myTimer  = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        [self.lapButton setEnabled:YES];
        
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
        
        [self stopTimer];
        
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}


- (void) resetTimer{
    
    _startDate = nil;
    _endDate = nil;
    
    [self stopTimer];
    
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [self.lapButton setEnabled:NO];
    
    self.timerText.text = @"00:00:00.000";
}

- (void)updateDisplayTime {
    /*_currentDate = [NSDate date];
    
    NSTimeInterval elapsedSeconds = [_currentDate timeIntervalSinceDate:_startDate];
    
    NSLog(@"elapsedSeconds: %f", elapsedSeconds);
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *elapsedDateComponents = [gregorianCalendar components:unitFlags fromDate:_startDate toDate:_currentDate options:0];
    
    //GRAB MILLISECONDS
    double intPart;
    double milliseconds = modf(elapsedSeconds, &intPart);
    
    _timerText.text = [NSString stringWithFormat:@"%02d:%02d:%06.3f", elapsedDateComponents.hour, elapsedDateComponents.minute, elapsedDateComponents.second + milliseconds];
    */
    
    //get current date
    _currentDate = [NSDate date];
    
    //get elapsed seconds since timer start
    NSTimeInterval elapsedSeconds = [_currentDate timeIntervalSinceDate:_startDate];
    
    //update display
    _timerText.text = [self formatTimeInterval:elapsedSeconds];
    
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


- (IBAction)lapButtonPressed:(id)sender {
}

- (IBAction)resetButtonPressed:(id)sender {
    [self resetTimer];
}


- (IBAction)startButtonPressed:(id)sender {
    [self startTimer];
}

@end
