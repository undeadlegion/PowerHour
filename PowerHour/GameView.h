//
//  GameView.h
//  Panda Alarm
//
//  Created by James Lubowich on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@interface GameView : UIView

//@property (nonatomic, assign) CGPoint circleCenter;
@property (nonatomic, assign) CGPoint circleTopLeft;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, assign) CGRect circleBounds;
@property (nonatomic, assign) BOOL gameStarted;
@property (nonatomic, assign) BOOL displayUI;
@property (assign, nonatomic) Player *currentPlayer;

//- (void)screenTapped:(id)sender;
- (CGPoint)randomPoint;
- (void)setRandomCenter;
- (bool)containsPoint:(CGPoint)point;
@end
