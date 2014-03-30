//
//  Player.m
//  PowerHour
//
//  Created by James Lubo on 3/27/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import "Player.h"

@implementation Player

+ (Player *)playerWithName:(NSString *)name color:(UIColor *)color {
    Player *newPlayer = [[Player alloc] init];
    newPlayer.playerName = name;
    newPlayer.playerColor = color;
    newPlayer.score = 0;
    newPlayer.maxScore = 0;
    return newPlayer;
}
@end
