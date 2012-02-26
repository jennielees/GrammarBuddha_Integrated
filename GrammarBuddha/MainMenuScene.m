//
//  MainMenuScene.m
//  SpaceViking
//
//  Created by Jennie Lees on 2/23/12.
//  Copyright 2012 Affect Labs Ltd. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

-(id)init {
	self = [super init];
	if (self != nil) {
		mainMenuLayer = [MainMenuLayer node];
		[self addChild:mainMenuLayer];
	}
	return self;
}

@end
