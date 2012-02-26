//
//  MainMenuLayer.m
//  Grammar
//
//  Created by Emmy Chen on 2/26/12.
//  Copyright 2012 Kuaitech. All rights reserved.
//

#import "MainMenuLayer.h"
#import "sentences.h"
#import "SimpleAudioEngine.h"

@interface MainMenuLayer() // slight hack to do private methods
-(void)displayMainMenu;
@end

@implementation MainMenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void)displayMainMenu {
    
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    
	
	// Main Menu
	CCMenuItemImage *arcadeButton = [CCMenuItemImage
                                     itemFromNormalImage:@"arcadeBtn.png"
                                     selectedImage:@"arcadeBtn.png"
                                     disabledImage:nil
                                     target:self
                                     selector:@selector(playArcade)];
    
    CCMenuItemImage *challengeButton = [CCMenuItemImage
                                        itemFromNormalImage:@"challengeBtn.png"
                                        selectedImage:@"challengeBtn.png"
                                        disabledImage:nil
                                        target:self
                                        selector:@selector(customUser)];
    
    CCMenuItemImage *practiceButton = [CCMenuItemImage
                                       itemFromNormalImage:@"practiceBtn.png"
                                       selectedImage:@"practiceBtn.png"
                                       disabledImage:nil
                                       target:self
                                       selector:@selector(customUser)];
    /*    CCMenuItemImage *customButton = [CCMenuItemImage
     itemFromNormalImage:@"fillerBtn.png"
     selectedImage:@"fillerBtn.png"
     disabledImage:nil
     target:self
     selector:@selector(customUser)];
     */
    
	mainMenu = [CCMenu
				menuWithItems:arcadeButton,challengeButton,practiceButton,nil];
	[mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
	[mainMenu setPosition: ccp(screenSize.width*2, screenSize.height/2)];
	id moveAction = [CCMoveTo actionWithDuration:1.2f
										position:ccp(screenSize.width * 0.85f, screenSize.height/2)];
	id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
	[mainMenu runAction:moveEffect];
	[self addChild:mainMenu z:0];
    
    
    // App name ease in
    CCSprite *titleNode = [CCSprite spriteWithFile:@"grammarBuddhaText.png"];
    titleNode.position = ccp(200,screenSize.height*1.8f);
    id move =  [CCMoveBy actionWithDuration:3 position:ccp(0,-screenSize.height)];
    id action = [CCEaseBounceOut actionWithAction:move];
    [titleNode runAction: action];
    
    [self addChild:titleNode];
	
}

-(void) playArcade {
    
    [[CCDirector sharedDirector] replaceScene:[Sentences scene]];
}

-(void) playChallenge {
   // [[GameManager sharedGameManager] runSceneWithID:kChallengeScene];
}

-(void) playPractice {
  //  [[GameManager sharedGameManager] runSceneWithID:kPracticeScene];
}

-(void) customUser {
   // [[GameManager sharedGameManager] runSceneWithID:kCustomScene];
}

-(id)init {
    
	self = [super init];
	
	if (self!= nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize;		
		CCSprite *background = [CCSprite spriteWithFile:@"MainMenuBackground.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		[self displayMainMenu];
		
		// Skipping the floating viking
	}
	return self;
    
}

-(void) dealloc {
    [super dealloc];
}

@end
