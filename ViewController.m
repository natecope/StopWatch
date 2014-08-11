//
//  ViewController.m
//  StopWatch
//
//  Created by Nathan Cope on 7/30/14.
//  Copyright (c) 2014 Nathan Cope. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <StopWatchDelegate>{

    StopWatch *_stopWatch;
    //NSDate *_currentDate;

}

@property (strong, nonatomic) IBOutlet UIView *masterView;
@property (strong, nonatomic) IBOutlet UIView *uiBaseView;
@property (weak, nonatomic) IBOutlet UILabel *timerText;
@property (weak, nonatomic) IBOutlet UILabel *lapTimerText;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *lapButton;
@property (weak, nonatomic) IBOutlet UIProgressView *secondsProgressBar;

- (IBAction)lapButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _stopWatch = [[StopWatch alloc]init];
    _stopWatch.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated{
    self.uiBaseView.center = self.masterView.center;
}


- (void) stopTimer{

    [self.lapButton setEnabled:NO];

    [_stopWatch stopTimer];
    
}

- (void) startTimer{
    
    [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    [self.lapButton setEnabled:YES];
    
    [_stopWatch startTimer];

}


- (void) resetTimer{
    
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.lapButton setEnabled:NO];
    self.timerText.text = @"00:00:00.000";
    self.lapTimerText.text = @"00:00:00.000";
    [self.secondsProgressBar setProgress:0];
    
    [_stopWatch resetTimer];
    
}


- (void) updateDisplayTime{
    
}



- (void)updateLapTimer{
    
    //get current date
    //_currentDate = [NSDate date];
    
    //get elapsed seconds since timer start
    NSTimeInterval elapsedSeconds = [[NSDate date] timeIntervalSinceDate:_stopWatch.startDate];
    
    //update display
    _lapTimerText.text = [_stopWatch formatTimeInterval:elapsedSeconds];
    
}

-(void)updateSecondsProgressBar:(float)milliseconds{
    [_secondsProgressBar setProgress:milliseconds animated:YES];
}


- (IBAction)lapButtonPressed:(id)sender {
    [self updateLapTimer];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self resetTimer];
}


- (IBAction)startButtonPressed:(id)sender {
    if(_stopWatch.startDate){
        [self stopTimer];
    } else {
        [self startTimer];
    }
}

#pragma mark - StopWatchDelegate
- (void) timeUpdated:(StopWatch *)stopWatch{
    
    NSTimeInterval duration = [stopWatch duration];
    
    _timerText.text = [stopWatch formatTimeInterval:duration];
}

@end
