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
@class Player;

@interface GameViewController : UIViewController <UINavigationBarDelegate>

#define kClassicMode    0
#define kRouletteMode 1
#define kRoundRobinMode 2
#define kMinigameMode   3

// game variables
@property (assign, nonatomic) NSInteger roundTimerLength;
@property (assign, nonatomic) NSInteger countdownLength;
@property (assign, nonatomic) NSInteger timeUntilCountdown;
@property (assign, nonatomic) NSInteger numberOfRounds;
@property (assign, nonatomic) double gameDifficulty;


@property (strong, nonatomic) UITapGestureRecognizer *singleTap;

@property (assign, nonatomic) NSInteger gameMode;
@property (assign, nonatomic) NSInteger roundNumber;

@property (nonatomic, strong) NSTimer *vibrateTimer;
@property (nonatomic, strong) NSTimer *gameTimer;
@property (nonatomic, strong) NSTimer *minigameTimer;
@property (strong, nonatomic) NSTimer *roundTimer;

@property (assign, nonatomic) BOOL gameStarted;
@property (assign, nonatomic) BOOL countdownStarted;
@property (assign, nonatomic) BOOL buttonTapped;
@property (copy, nonatomic) NSDate *startDate;

@property (weak, nonatomic) IBOutlet GameView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastRoundLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) Player *currentPlayer;
- (IBAction)exit:(id)sender;

- (id)init; 
- (void)screenTapped:(id)sender;
- (void)startGame;
- (void)endGame;

@end
