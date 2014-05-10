//
//  SocialCrawlViewController.m
//  PowerHour
//
//  Created by James Lubo on 3/25/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import "SocialCrawlViewController.h"
#import "GameViewController.h"
#import "AddPlayerTableViewController.h"

@interface SocialCrawlViewController ()
@property (strong, nonatomic)AddPlayerTableViewController *viewController;
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
     self.viewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"classic"]) {
        self.viewController.gameMode = kClassicMode;
    } if ([segue.identifier isEqualToString:@"roulette"]) {
        self.viewController.gameMode = kRouletteMode;
    } if ([segue.identifier isEqualToString:@"cooperative"]) {
        self.viewController.gameMode = kCooperativeMode;
    } if ([segue.identifier isEqualToString:@"minigame"]) {
        self.viewController.gameMode = kMinigameMode;
    }
}
@end
