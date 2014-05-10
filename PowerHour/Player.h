//
//  Player.h
//  PowerHour
//
//  Created by James Lubo on 3/27/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (copy, nonatomic) UIColor *color;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) NSInteger maxScore;
+ (Player *)playerWithName:(NSString *)name color:(UIColor *)color;
@end
