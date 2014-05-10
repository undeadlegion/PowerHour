//
//  PlayerTableViewCell.m
//  PowerHour
//
//  Created by James Lubo on 4/4/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import "PlayerTableViewCell.h"
#import "Player.h"

@implementation PlayerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.textField.delegate = self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"did end editing:%@", self.player.name);
    self.player.name = self.textField.text;
//        self.player.color = self.selectedColor;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        self.player.name = self.textField.text;
//        self.player.color = self.selectedColor;
        [self.textField resignFirstResponder];
        
        return NO;
    }
    return YES;
}
@end
