//
//  GameViewController.m
//  Panda Alarm
//
//  Created by James Lubowich on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"

@implementation GameViewController
@synthesize gameView, singleTap, tapsLeft, timer, vibrateTimer, countdownTimer;

- (id)init {
    self = [super initWithNibName:@"GameViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    [gameView addGestureRecognizer:singleTap];
    tapsLeft = 5;
    timer = nil;
    countdownTimer = nil;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.resetTimer = nil;
    self.gameStarted = NO;
    self.startDate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)startGame{
    NSLog(@"Start Game");
    self.gameStarted = YES;
    self.startDate = [NSDate date];
    
    self.resetTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(resetTimer:) userInfo:nil repeats:YES];
    //create vibrating timer
    vibrateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(vibrateFire:) userInfo:nil repeats:YES];
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
//    // instantiate a music player
//    MPMusicPlayerController *myPlayer =
//    [MPMusicPlayerController applicationMusicPlayer];
//    // assign a playback queue containing all media items on the device
//    [myPlayer setQueueWithQuery: [MPMediaQuery songsQuery]];
//    myPlayer.volume = 1.0;
//    // start playing from the beginning of the queue
//    [myPlayer play];
    
}
- (void)endGame{
    self.gameStarted = NO;
    [timer invalidate];
    [vibrateTimer invalidate];
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    [[MPMusicPlayerController applicationMusicPlayer] pause];
}

- (void)vibrateFire:(NSTimer *) theTimer{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}


- (void)screenTapped:(id)sender{
    NSLog(@"Screen Tapped object %@", sender);
    
    if (!self.gameStarted) {
        [self startGame];
    } else {
//    CGPoint point = [singleTap locationInView:gameView];
//        if([gameView containsPoint:point]){
//            tapsLeft--;
//            if(tapsLeft == 0){
//                [self endGame];
//            }
//            else{
//                [gameView setRandomCenter];
//                [gameView setNeedsDisplay];
//                [self setNextTimer];
//            }
//        }
    }
    
//    NSLog(@"Point (%f, %f)", point.x, point.y);
}

- (void)setNextTimer{
    if(timer != nil)
        [timer invalidate];
    
    double interval = 0.0;
    switch(tapsLeft){
        case 4:
            interval = .85;
            [gameView setRadius:150];
            break;
        case 3:
            interval = .85;
            [gameView setRadius:115];
            break;
        case 2:
            interval = .55;
            [gameView setRadius:80];
            break;
        case 1:
            interval = .45;
            [gameView setRadius:65];
            break;
    }
    timer = [[NSTimer alloc] initWithFireDate:
    [NSDate dateWithTimeIntervalSinceNow:.1] interval:interval target:self selector:
             @selector(timerFireMethod:) userInfo:nil repeats:YES];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    [currentRunLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}
             
- (void)timerFireMethod: (NSTimer *)theTimer{
    [gameView setRandomCenter];
    [gameView setNeedsDisplay];
}

- (void)resetTimer: (NSTimer *)timer {
    NSLog(@"Timer reset!");
    self.startDate = [NSDate date];
    [countdownTimer invalidate];
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

- (void)updateTimer: (NSTimer *)timer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss:SS"];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    interval = 60 - interval;
    
    NSDate *timeLeft = [NSDate dateWithTimeIntervalSince1970:interval];
    if (interval < 10) {
        self.timerLabel.textColor = [UIColor redColor];
    } else {
        self.timerLabel.textColor = [UIColor blackColor];
    }
    self.timerLabel.text = [dateFormatter stringFromDate:timeLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
