//
//  GameSettingsTableViewController.m
//  PowerHour
//
//  Created by James Lubo on 5/9/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import "GameSettingsTableViewController.h"
#import "GameViewController.h"

@interface GameSettingsTableViewController ()

@end

@implementation GameSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDefaults];
}

- (void)setupDefaults
{
    if (self.gameMode == kClassicMode) {
        self.gameModeCell.detailTextLabel.text = @"Classic Mode";
        [self.roundSlider setValue:60];
        [self.countdownSlider setValue:10];
        [self.roundSlider setValue:60];
    } else if (self.gameMode == kRouletteMode) {
        self.gameModeCell.detailTextLabel.text = @"Roulette Mode";
        [self.roundSlider setValue:9];
        [self.countdownSlider setValue:7];
        [self.numberOfRoundsSlider setValue:90];
    } else if (self.gameMode == kCooperativeMode) {
        self.gameModeCell.detailTextLabel.text = @"Cooperative Mode";
        [self.roundSlider setValue:9];
        [self.countdownSlider setValue:9];
        [self.numberOfRoundsSlider setValue:90];
    } else if (self.gameMode == kMinigameMode) {
        self.gameModeCell.detailTextLabel.text = @"Minigame Mode";
        [self.roundSlider setValue:9];
        [self.countdownSlider setValue:9];
        [self.numberOfRoundsSlider setValue:90];
    }
    [self roundChanged:self.roundSlider];
    [self countdownChanged:self.countdownSlider];
    [self numberOfRoundsChanged:self.numberOfRoundsSlider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameViewController *viewController = (GameViewController *)[segue destinationViewController];
    viewController.title = self.gameModeCell.detailTextLabel.text;
    viewController.roundTimerLength = (int)self.roundSlider.value;
    viewController.countdownLength = (int)self.countdownSlider.value;
    viewController.numberOfRounds = (int)self.numberOfRoundsSlider.value;
    viewController.gameDifficulty = 1;
    viewController.gameMode = self.gameMode;
}

- (IBAction)roundChanged:(id)sender {
    self.roundLabel.text = [NSString stringWithFormat:@"%ds", (int)((UISlider *)sender).value];
    self.countdownSlider.maximumValue = self.roundSlider.value;
    if (self.roundSlider.value <= self.countdownSlider.value) {
        [self.countdownSlider setValue:self.roundSlider.value animated:YES];
        [self countdownChanged:self.countdownSlider];
    }
}
- (IBAction)countdownChanged:(id)sender {
    self.countdownLabel.text = [NSString stringWithFormat:@"%ds", (int)((UISlider *)sender).value];
}
- (IBAction)numberOfRoundsChanged:(id)sender {
    self.numberOfRoundsLabel.text = [NSString stringWithFormat:@"%d", (int)((UISlider *)sender).value];
}

@end
