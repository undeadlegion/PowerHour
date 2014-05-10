//
//  GameSettingsTableViewController.h
//  PowerHour
//
//  Created by James Lubo on 5/9/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSettingsTableViewController : UITableViewController

@property (assign, nonatomic) NSInteger gameMode;
@property (weak, nonatomic) IBOutlet UITableViewCell *gameModeCell;

@property (weak, nonatomic) IBOutlet UISlider *roundSlider;
@property (weak, nonatomic) IBOutlet UISlider *countdownSlider;
@property (weak, nonatomic) IBOutlet UISlider *numberOfRoundsSlider;

@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRoundsLabel;

- (IBAction)roundChanged:(id)sender;
- (IBAction)countdownChanged:(id)sender;
- (IBAction)numberOfRoundsChanged:(id)sender;

@end
