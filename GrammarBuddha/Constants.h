/*
 *  Constants.h
 *  SpaceViking
 *
 *  Created by Jennie Lees on 2/23/12.
 *  Copyright 2012 Affect Labs Ltd. All rights reserved.
 *
 */

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20

typedef enum {
	kNoSceneUninitialized=0,
	kMainMenuScene=1,
	kOptionsScene=2,
	kCreditsScene=3,
	kIntroScene=4,
	kLevelCompleteScene=5,
    kCustomScene=6,
    kArcadeScene=101,
    kChallengeScene=102,
    kPracticeScene=103,
	kGameLevel1=101,
	kGameLevel2=102,
	kGameLevel3=103,
	kGameLevel4=104,
	kGameLevel5=105,
	kCutSceneForLevel2=201
} SceneTypes;

typedef enum {
	kLinkTypeBookSite,
	kLinkTypeDeveloperSiteRod,
	kLinkTypeDeveloperSiteRay,
	kLinkTypeArtistSite,
	kLinkTypeMusicianSite
} LinkTypes;


// 0 for debug OFF, 1 for debug ON
#define ENEMY_STATE_DEBUG 0

// Box2D conversions

#define PTM_RATIO ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 100.0 : 50.0)
