//
//  SelectScene.m
//  SpaceViking
//
//  Created by Jennie Lees on 2/23/12.
//  Copyright 2012 Affect Labs Ltd. All rights reserved.
//

#import "SelectScene.h"

@implementation SelectScene

-(id)init {
	self = [super init];
	if (self != nil) {
		selectLayer = [SelectLayer node];
		[self addChild:selectLayer];
	}
	return self;
}

@end
