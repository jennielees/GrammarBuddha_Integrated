//
//  GameManager.h
//  SpaceViking
//
//  Created by Jennie Lees on 2/23/12.
//  Copyright 2012 Affect Labs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameManager : NSObject {
	BOOL isMusicON;
	BOOL isSoundEffectsON;
	BOOL hasPlayerDied;
    BOOL isMultiplayerON;
    int latestScore;
	SceneTypes currentScene;
    NSMutableSet *selectedCategories;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON;
@property (readwrite) BOOL hasPlayerDied;
@property (readwrite) BOOL isMultiplayerON;
@property (readwrite) int latestScore;
@property (readwrite, retain) NSSet *selectedCategories;

+ (GameManager*) sharedGameManager; // Class method returning one and only (singleton) instance of GameManager
- (void)runSceneWithID:(SceneTypes)sceneID; // called when director (via gameManager) has to change which scene is running
- (void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen; // open URL based on link type


@end
