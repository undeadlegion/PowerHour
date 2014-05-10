//
//  PlayerTableViewCell.h
//  PowerHour
//
//  Created by James Lubo on 4/4/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;

@interface PlayerTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) Player *player;
@property (strong, nonatomic) UIColor *selectedColor;
@end
