//
//  CustomCCNode.m
//  Coco2dTest2
//
//  Created by Ethan Mick on 3/11/10.
//  Copyright 2010 Wayfarer. All rights reserved.
//

#import "CustomCCNode.h"
#import "cocos2d.h"

@implementation CustomCCNode

@synthesize linkedNode;
@synthesize isSelected;

- (CGRect)rect
{
    CGSize s = [self.texture contentSize];
    return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}



- (BOOL)containsTouchLocation:(UITouch *)touch
{
    return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}


- (void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}   


- (void)addGlowLink:(CustomCCNode *) linked
{
    self.linkedNode = linked;
}

- (void)toggleGlow {
    if (self.linkedNode.opacity == 0) {
        self.linkedNode.opacity = 255.0;
        self.isSelected = YES;
    } else {
        self.linkedNode.opacity = 0.0;
        self.isSelected = NO;
    }
    NSLog(@"Toggling a glow");
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"ccTouchBegan Called");
    if ( ![self containsTouchLocation:touch] ) return NO;
    NSLog(@"ccTouchBegan returns YES");
    NSLog(@"%i", self.tag);
    [self toggleGlow];
    NSLog(@"calling toggle glow");
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    NSLog(@"ccTouch Moved is called");
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"ccTouchEnded is called");
}


@end