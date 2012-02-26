//
//  GameManager.m
//  SpaceViking
//
//  Created by Jennie Lees on 2/23/12.
//  Copyright 2012 Affect Labs Ltd. All rights reserved.
//

#import "GameManager.h"
#import "MainMenuLayer.h"
#import "SelectScene.h"
#import "Sentences.h"

@implementation GameManager

static GameManager* _sharedGameManager = nil; // define the singleton object

@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize hasPlayerDied;
@synthesize selectedCategories;//plus custom getter setter
@synthesize latestScore;
@synthesize isMultiplayerON;

+ (GameManager*) sharedGameManager {

	@synchronized([GameManager class]) { // even if two instances call this at once, it will only happen once!
		if (!_sharedGameManager)
			[[self alloc] init];
		return _sharedGameManager;
	}
	return nil;
	
}

+ (id) alloc {
	// Allocate ze memory
	@synchronized([GameManager class]) {
	
		NSAssert(_sharedGameManager == nil, 
				 @"attempted to allocate a second instance of the GameManager singleton"); // Checks to ensure it's nil and stops if it isn't
		_sharedGameManager = [super alloc];
		return _sharedGameManager;
		
	}
	return nil;
}

- (void) toggleCategorySelection: (NSString *)cat {
    // using a set to quickly query whether the ints are there.
    if ([selectedCategories containsObject:cat]) {
        // It was selected. Deselect!
        [selectedCategories removeObject:cat];
        NSLog(@"Removing %d from set", cat); 
    } else {
        // Select it
        [selectedCategories addObject:cat];
        NSLog(@"Adding %d to set", cat);
    }
}

- (id) init {
	// Initialize ze class
	self = [super init];
	if (self != nil) {
		// game manager is initialised
		CCLOG(@"Game Manager Singleton.. INIT!");
		isMusicON = YES;
		isSoundEffectsON = YES;
		hasPlayerDied = NO;
		currentScene = kNoSceneUninitialized;
	}
	return self;
}

// Now the actual manager part of the class

- (void)runSceneWithID:(SceneTypes)sceneID {

	SceneTypes oldScene = currentScene;
	currentScene = sceneID;
	
	id sceneToRun = nil;
	
	switch(sceneID) {
		case kMainMenuScene:
			sceneToRun = [MainMenuLayer scene];
			break;
        case kArcadeScene:
            sceneToRun = [Sentences scene];
            break;
        case kCustomScene:
            sceneToRun = [SelectScene node];
            break;
//		case kIntroScene:
//			sceneToRun = [IntroScene node];
//			break;

		default:
			CCLOG(@"Cannot switch to unknown ID");
			return;
			break;
	}
			
	if (sceneToRun == nil) {
		// revert back
		currentScene = oldScene;
		return;
	
	}
	
	// Some menu scene specific stuff.
	if (sceneID < 100) { // it's a menu
	
		if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
			CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels;
			if (screenSize.width == 960.0f) {
				// iPhone 4 Retina
				[sceneToRun setScaleX:0.9375f];
				[sceneToRun setScaleY:0.8333f];
				CCLOG(@"GM: Scaling for iPhone 4 Retina");
			} else {
				[sceneToRun setScaleX:0.4688f];
				[sceneToRun setScaleY:0.4166f];
				CCLOG(@"GM: Scaling for iPhone 3G non-retina");
			}
		}
	
	}
	
	if ([[CCDirector sharedDirector] runningScene] == nil) {
		[[CCDirector sharedDirector] runWithScene:sceneToRun];
	} else {
		[[CCDirector sharedDirector] replaceScene:sceneToRun];
	}
	
}

-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen {
	// Skimping on implementation for now. Pg. 178
	// Do nothing, void method so no return.
	
}

@end
