//
//  SocialCrawlViewController.m
//  PowerHour
//
//  Created by James Lubo on 3/25/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import "SocialCrawlViewController.h"
#import "GameViewController.h"

@interface SocialCrawlViewController ()

@end

@implementation SocialCrawlViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameViewController *viewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"classic"]) {
        viewController.gameMode = kClassicMode;
        viewController.title = @"Classic Mode";
        viewController.roundTimerLength = 60;
        viewController.countdownLength = 10;
        viewController.numberOfRounds = 60;
        viewController.gameDifficulty = 1;
    } if ([segue.identifier isEqualToString:@"roulette"]) {
        viewController.gameMode = kRouletteMode;
        viewController.title = @"Roulette Mode";
        viewController.roundTimerLength = 10;
        viewController.countdownLength = 7;
        viewController.numberOfRounds = 80;
        viewController.gameDifficulty = 1;
    } if ([segue.identifier isEqualToString:@"roundRobin"]) {
        viewController.gameMode = kRoundRobinMode;
        viewController.title = @"Cooperative Mode";
//        viewController.roundTimerLength = 15;
//        viewController.countdownLength = 7;
        viewController.roundTimerLength = 5;
        viewController.countdownLength = 3;
        viewController.numberOfRounds = 50;
        viewController.gameDifficulty = 1;
    } if ([segue.identifier isEqualToString:@"minigame"]) {
        viewController.gameMode = kMinigameMode;
        viewController.title = @"Minigame Mode";
        viewController.roundTimerLength = 4;
        viewController.countdownLength = 4;
        viewController.numberOfRounds = 30;
        viewController.gameDifficulty = .3;
    }
}
@end
