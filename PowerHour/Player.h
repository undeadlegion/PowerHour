//
//  Player.h
//  PowerHour
//
//  Created by James Lubo on 3/27/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (copy, nonatomic, getter = color) UIColor *playerColor;
@property (copy, nonatomic, getter = name) NSString *playerName;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) NSInteger maxScore;
+ (Player *)playerWithName:(NSString *)name color:(UIColor *)color;
@end
