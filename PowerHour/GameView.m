//
//  GameView.m
//  Panda Alarm
//
//  Created by James Lubowich on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"
#import "Player.h"

@implementation GameView


- (id)initWithFrame:(CGRect)frame {
    NSLog(@"Init GameView with Frame");
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"Init GameView with Coder");
    if(self = [super initWithCoder:aDecoder]){
        self.radius = 100;
        CGRect frame = [self frame];
        self.circleTopLeft = CGPointMake(frame.size.width/2 - self.radius, frame.size.height/2 - self.radius);
        self.gameStarted = NO;
        self.displayUI = YES;
            
    }
    return self;
}


- (void)setDisplayUI:(BOOL) shouldDisplay {
    if (_displayUI != shouldDisplay) {
        _displayUI = shouldDisplay;
        [self setNeedsDisplay];
    }
}

- (void)setRandomCenter {
    self.circleTopLeft = [self randomPoint];
    [self setNeedsDisplay];
}

- (CGPoint)randomPoint {
    int x = arc4random()% (int)(self.bounds.size.width - 2*self.radius);
    int y = arc4random()% (int)(self.bounds.size.height - 2*self.radius);
    
//    NSLog(@"Rand %d, %d", x, y);
    CGPoint point = {x,y};
    return point;
}

- (bool)containsPoint:(CGPoint)point{
    return CGRectContainsPoint(self.circleBounds, point);
}

- (void)drawRect:(CGRect)rect {
    if (!self.displayUI) {
        return;
    }

	CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect frame = [self frame];
    self.circleBounds = CGRectMake(self.circleTopLeft.x, self.circleTopLeft.y, self.radius*2, self.radius*2);
    
//    NSLog(@"View Frame: %@", NSStringFromCGRect(frame));
//    NSLog(@"View Bounds: %@", NSStringFromCGRect(self.bounds));
//    NSLog(@"Top Left Point:%@", NSStringFromCGPoint(self.circleTopLeft));
//    NSLog(@"Circle Bounds:%@", NSStringFromCGRect(self.circleBounds));

    
    NSAttributedString *messageStr, *playerStr;
    UIFont *font = [UIFont fontWithName:@"Arial" size:48];
    UIColor *textColor = [UIColor blackColor];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor};
	UIColor* currentColor;
    
    int x, y1, y2;
    if (!self.gameStarted) {
        messageStr = [[NSAttributedString alloc] initWithString:@"Start!" attributes:dict];
        currentColor = [UIColor redColor];

        x = self.circleTopLeft.x + self.radius/4;
        y1 = 0;
        y2 = self.circleTopLeft.y + self.radius*3/4;

    } else {
        messageStr = [[NSAttributedString alloc] initWithString:@"Drink!" attributes:dict];
        playerStr = [[NSAttributedString alloc] initWithString:[self.currentPlayer name] attributes:dict];
        currentColor = [self.currentPlayer color];

        x = self.circleTopLeft.x + self.radius/4;
        y1 = self.circleTopLeft.y + self.radius/2;
        y2 = self.circleTopLeft.y + self.radius*5/4;
    }
    
	CGContextSetLineWidth(context,4);
    CGContextSetFillColorWithColor(context, currentColor.CGColor);
    CGContextFillEllipseInRect(context, self.circleBounds);


    [playerStr drawAtPoint:CGPointMake(x, y1)];
    [messageStr drawAtPoint:CGPointMake(x, y2)];
}
@end
