//
//  GameViewController.m
//  Panda Alarm
//
//  Created by James Lubowich on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"
#import "Player.h"

#define kGameTimerLength .01

@implementation GameViewController

- (IBAction)exit:(id)sender {
    [self endGame];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)init {
    self = [super initWithNibName:@"GameViewController" bundle:nil];
    return self;
}

- (void)setRoundNumber:(NSInteger)roundNumber {
    _roundNumber = roundNumber;
    self.roundLabel.text = [NSString stringWithFormat:@"%d", (int)_roundNumber];
}

- (NSMutableArray *)players {
    if (!_players) {
        _players = [[NSMutableArray alloc] init];
    }
    return _players;
}
- (NSMutableArray *)nextPlayers {
    if (!_nextPlayers) {
        _nextPlayers = [[NSMutableArray alloc] init];
    }
    return _nextPlayers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.title;
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    [self.gameView addGestureRecognizer:self.singleTap];
    self.gameTimer = nil;
    self.roundTimer = nil;
    self.gameStarted = NO;
    self.startDate = nil;
    self.progressView.progress = 1;
    self.roundNumber = 0;
    self.timeUntilCountdown = self.roundTimerLength - self.countdownLength;

    self.scoreLabel.textColor = [UIColor blackColor];
    self.roundLabel.textColor = [UIColor blackColor];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", 0];
    self.lastRoundLabel.text = [NSString stringWithFormat:@"/%zd", self.numberOfRounds];
    self.timerLabel.text = [NSString stringWithFormat:@"%zd:00", self.roundTimerLength];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupPlayers {
//    Player *player1 = [Player playerWithName:@"Erin" color:[UIColor magentaColor]];
    Player *player2 = [Player playerWithName:@"Kevin" color:[UIColor blueColor]];
    Player *player3 = [Player playerWithName:@"Colin" color:[UIColor greenColor]];
    Player *player4 = [Player playerWithName:@"Jamie" color:[UIColor orangeColor]];
    
    [self.players addObjectsFromArray:@[ player2, player3, player4]];
    self.currentPlayer = player2;
    self.gameView.currentPlayer = self.currentPlayer;
    [self randomizeNextPlayers];
}

- (void)randomizeNextPlayers {
    [self.nextPlayers addObjectsFromArray:self.players];
}

- (void)endGame {
    // invalidate timers
    [self.gameTimer invalidate];
    [self.vibrateTimer invalidate];
    [self.minigameTimer invalidate];
    [self.roundTimer invalidate];

    // reset state
    self.gameStarted = NO;
    self.gameView.gameStarted = NO;
    self.gameView.displayUI = YES;
    self.roundNumber = 0;

    // update UI
    self.roundLabel.textColor = [UIColor blackColor];
    self.scoreLabel.textColor = [UIColor blackColor];
    self.timerLabel.textColor = [UIColor blackColor];

    [self.gameView setNeedsDisplay];
    self.progressView.progress = 1;
//    [[MPMusicPlayerController applicationMusicPlayer] pause];
}

- (void)vibrateFire:(NSTimer *) theTimer{
//    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

- (void)screenTapped:(id)sender{
    NSLog(@"Screen Tapped object %@", sender);

    // start the game
    if (!self.gameStarted) {
        self.gameView.displayUI = NO;
        [self startGame];

    // is there a button
    } else if(self.countdownStarted && !self.buttonTapped) {
        CGPoint point = [self.singleTap locationInView:self.gameView];
        // was it tapped
        if ([self.gameView containsPoint:point]){
            self.currentPlayer.score++;
            self.coopScore++;
            self.buttonTapped = YES;
            self.gameView.displayUI = NO;
            
            if (self.gameMode == kRoundRobinMode) {
                self.scoreLabel.text = [NSString stringWithFormat:@"%zd", self.coopScore];
                self.scoreLabel.textColor = [UIColor blackColor];
                
            } else {
                self.scoreLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currentPlayer.score, self.currentPlayer.maxScore+1];
            }
            self.timerLabel.textColor = [UIColor blackColor];
            [self.vibrateTimer invalidate];
        }
    }
}

- (void)selectNextPlayer {
    if ([self.nextPlayers count] == 0) {
        [self.nextPlayers addObjectsFromArray:self.players];
    }
    if (self.gameMode == kRoundRobinMode) {
        NSInteger playerIndex = arc4random()%([self.nextPlayers count]);
        self.currentPlayer = [self.nextPlayers objectAtIndex:playerIndex];
        [self.nextPlayers removeObject:self.currentPlayer];
        
    } else if (self.gameMode == kMinigameMode) {
        NSInteger playerIndex = [self.players indexOfObject:self.currentPlayer];
        if (playerIndex + 1 == [self.players count]) {
            self.currentPlayer = self.players[0];
        } else {
            self.currentPlayer = self.players[playerIndex + 1];
        }
        self.gameView.currentPlayer = self.currentPlayer;
    } else if (self.gameMode == kRouletteMode) {
        NSInteger playerIndex = arc4random()%([self.players count]);
        NSLog(@"Player Index:%zd", playerIndex);
        self.currentPlayer = self.players[playerIndex];
        self.gameView.currentPlayer = self.currentPlayer;
    }
}

- (void)updateUI {

    
    // view did load
    
    // game over

    
}
- (void)startGame{
    NSLog(@"Start Game");
    // set state variables
    self.gameStarted = YES;
    self.gameView.gameStarted = YES;
    self.gameView.displayUI = NO;
    self.roundNumber = 1;
    [self setupPlayers];
    
    self.lastRoundLabel.text = [NSString stringWithFormat:@"/%zd", self.numberOfRounds];
    self.timerLabel.text = [NSString stringWithFormat:@"%zd:00", self.roundTimerLength];
    self.timerLabel.textColor = [UIColor blackColor];
    if (self.gameMode == kRoundRobinMode) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%zd", self.coopScore];
        self.scoreLabel.textColor = [UIColor blackColor];
        self.roundLabel.textColor = self.currentPlayer.color;
    } else if (self.gameMode == kRouletteMode) {
        self.scoreLabel.text = @"";
        self.scoreLabel.textColor = [UIColor blackColor];
        self.roundLabel.textColor = [UIColor blackColor];
    }
    
    // instantiate a music player
//    MPMusicPlayerController *myPlayer =
//    [MPMusicPlayerController applicationMusicPlayer];
    // assign a playback queue containing all media items on the device
//    [myPlayer setQueueWithQuery: [MPMediaQuery songsQuery]];
//    myPlayer.volume = 1.0;
    // start playing from the beginning of the queue
//    [myPlayer play];
    
    [self resetTimers];
}

- (void)resetTimers {
    NSLog(@"reset timers");
    [self.gameTimer invalidate];
    [self.vibrateTimer invalidate];
    [self.minigameTimer invalidate];
    [self.roundTimer invalidate];
    
    NSDate *countdownFireDate, *roundFireDate;
    self.startDate = [NSDate date];
    countdownFireDate = [self.startDate dateByAddingTimeInterval:self.timeUntilCountdown];
    roundFireDate = [self.startDate dateByAddingTimeInterval:self.roundTimerLength];

//    NSTimeInterval minigameInterval = 1 - (self.currentPlayer.score/(self.numberOfRounds+self.gameDifficulty));
    if (self.roundNumber < self.numberOfRounds/3) {
        self.gameDifficulty = .7;
        self.gameView.radius = 100;
    } else if (self.roundNumber < self.numberOfRounds*2/3) {
        self.gameDifficulty = .4;
        self.gameView.radius = 75;
    } else {
        self.gameDifficulty = .2;
        self.gameView.radius = 40;
    }
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:kGameTimerLength target:self selector:@selector(gameTimer:) userInfo:nil repeats:YES];
    self.vibrateTimer = [[NSTimer alloc] initWithFireDate:countdownFireDate interval:1 target:self selector:@selector(vibrateFire:) userInfo:nil repeats:YES];
    self.minigameTimer = [[NSTimer alloc] initWithFireDate:countdownFireDate interval:self.gameDifficulty target:self selector:@selector(minigameTimer:) userInfo:nil repeats:YES];
    self.roundTimer = [[NSTimer alloc] initWithFireDate:roundFireDate interval:self.roundTimerLength target:self selector:@selector(roundTimer:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.vibrateTimer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:self.minigameTimer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:self.roundTimer forMode:NSDefaultRunLoopMode];
}

- (void)startCountdown {
    NSLog(@"start countdown");
    self.countdownStarted = YES;
    self.timerLabel.textColor = [UIColor redColor];

    if (self.gameMode == kRoundRobinMode) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%zd", (int)self.coopScore];
        self.scoreLabel.textColor = [UIColor blackColor];
    } else {
        self.scoreLabel.text = [NSString stringWithFormat:@"%d/%d", (int)self.currentPlayer.score, (int)self.currentPlayer.maxScore+1];
        self.scoreLabel.textColor = self.currentPlayer.color;
    }
    self.roundLabel.textColor = self.currentPlayer.color;
    
    // show button
    if (!self.buttonTapped) {
        self.gameView.displayUI = YES;
    }
}

- (void)gameTimer:(NSTimer *)timer {
    NSLog(@"gameTimer");
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss:SS"];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    float timeLeft = self.roundTimerLength - interval;
    NSDate *timeLeftDate = [NSDate dateWithTimeIntervalSince1970:timeLeft];
    
    float numerator = (self.roundNumber-1) * self.roundTimerLength + interval;
    float denomenator = self.numberOfRounds * self.roundTimerLength;
    float progress = 1 - (numerator/denomenator);
    
    [self.progressView setProgress:progress animated:YES];
    if (timeLeft < self.countdownLength && !self.countdownStarted) {
        [self startCountdown];
    }
    self.timerLabel.text = [dateFormatter stringFromDate:timeLeftDate];
}

- (void)roundTimer: (NSTimer *)timer {
    NSLog(@"roundTimer");
    if (self.roundNumber == self.numberOfRounds) {
        [self endGame];
        return;
    }
    // reset state variables
    self.roundNumber++;
    self.currentPlayer.maxScore++;
    self.startDate = [NSDate date];
    self.countdownStarted = NO;
    self.buttonTapped = NO;
    [self selectNextPlayer];
    
    // reset UI
    self.gameView.displayUI = NO;
    self.timerLabel.textColor = [UIColor blackColor];
    
    if (self.gameMode == kRoundRobinMode) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%d", (int)self.coopScore];
        self.scoreLabel.textColor = [UIColor blackColor];
        self.roundLabel.textColor = self.currentPlayer.color;
    } else if (self.gameMode == kRouletteMode) {
        self.scoreLabel.text = @"";
        self.scoreLabel.textColor = [UIColor blackColor];
        self.roundLabel.textColor = [UIColor blackColor];
    }
    
    [self scheduleNextNotification];
    [self resetTimers];
}

- (void)minigameTimer:(NSTimer *)timer {
    NSLog(@"minigame fire");
    if (self.gameMode == kMinigameMode) {
        [self.gameView setRandomCenter];
    }
}

- (void)scheduleNextNotification {
    UILocalNotification *notification = [[UILocalNotification alloc] init];

    notification.fireDate = [self.startDate dateByAddingTimeInterval:self.timeUntilCountdown];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = [NSString stringWithFormat:@"Take a drink!"];
    notification.alertAction = @"View";
    notification.userInfo = nil;
    NSLog(@"Scheduled: %@", notification.fireDate);

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
