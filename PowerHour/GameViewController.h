//
//  GameViewController.h
//  Panda Alarm
//
//  Created by James Lubowich on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

@class GameView;

@interface GameViewController : UIViewController <UINavigationBarDelegate>

@property (nonatomic, strong) IBOutlet GameView *gameView;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, assign) NSInteger tapsLeft;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *vibrateTimer;
@property (nonatomic, strong) NSTimer *countdownTimer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic, assign) BOOL gameStarted;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSTimer *resetTimer;

- (id)init; 
- (void)screenTapped:(id)sender;
- (void)timerFireMethod:(NSTimer *)theTimer;
- (void)vibrateFire:(NSTimer *)theTImer;
- (void)setNextTimer;
- (void)startGame;
- (void)endGame;

@end
