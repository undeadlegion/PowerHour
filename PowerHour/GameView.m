//
//  GameView.m
//  Panda Alarm
//
//  Created by James Lubowich on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"

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
        self.tapsLeft = 5;
        CGRect frame = [self frame];
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        
//        NSLog(@"Frame: %@", frame.origin);
        NSLog(@"Size: (%f, %f)", frame.size.width, frame.size.height);
        NSLog(@"Center: (%f, %f)", self.center.x, self.center.y);

            
    }
    return self;
}

- (void)setRandomCenter{
    self.center = [self randomPoint];
}

- (CGPoint)randomPoint {
    CGRect frame = [self frame];
//    NSLog(@"Frame.origin: %@", frame.origin);
    int x = arc4random()% (int)(frame.origin.x + frame.size.width - self.radius);
    int y = arc4random()% (int)(frame.origin.y + frame.size.height - self.radius);
    x += self.radius;
    y += self.radius;
    
//    NSLog(@"Frame bounds O:(%f,%f) S:%fx%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//    NSLog(@"Rand %d, %d", x, y);
    CGPoint point = {x,y};
    return point;
}

- (bool)containsPoint:(CGPoint)point{
    return CGRectContainsPoint(self.bounds, point);
}

- (void)drawRect:(CGRect)rect {
	UIColor* currentColor = [UIColor redColor];
	CGContextRef context = UIGraphicsGetCurrentContext();
    self.bounds = CGRectMake(self.center.x - self.radius, self.center.y - self.radius,self.radius*2,self.radius*2);
    
//    self.bounds = CGRectMake(110, 120, 100, 100);
    
    NSLog(@"Bounds: %@", NSStringFromCGRect(self.bounds));
	CGContextSetLineWidth(context,4);
    CGContextSetFillColorWithColor(context, currentColor.CGColor);
    CGContextFillEllipseInRect(context, self.bounds);

    UIFont *font = [UIFont fontWithName:@"Arial" size:48];
    UIColor *textColor = [UIColor blackColor];
    NSDictionary *dict = @{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor};
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"Drink!" attributes:dict];
    [attrStr drawInRect:self.bounds];
    
}



@end
