//
//  Result.m
//  Grammar
//
//  Created by Emmy Chen on 2/26/12.
//  Copyright 2012 Kuaitech. All rights reserved.
//

#import "Result.h"
#import "GameConfig.h"
#import "MainMenuLayer.h"
@implementation Result
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Result *layer = [Result node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init {
    if(self = [super initWithColor:ccc4(255, 255, 255, 255)]) {
        //CGSize winSize = [CCDirector sharedDirector].winSize;
        /*for (int i = 0; i < SENTENCES_NUM; i++) {
            CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Sentence %d:  ", i] fontName:@"Arial" fontSize:50];
            label.position = ccp(winSize.width/2, winSize.height - 100*(i+1));
            label.color = ccBLACK;
            [self addChild:label];
            CCSprite *result = [CCSprite spriteWithFile:@"right1.png"];
            result.position = ccp(winSize.width/2+label.contentSize.width/2+20,  winSize.height - 100*(i+1));
            [self addChild:result];
        }
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"homeBtn.png" selectedImage:@"homeBtn.png" target:self selector:@selector(goMenu)];
         
        back.position= ccp(50, 50);
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(0,0);
        [self addChild:menu];
         */
        CGSize screenSize = [CCDirector sharedDirector].winSize;		
		CCSprite *background = [CCSprite spriteWithFile:@"victoryScreen.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
        
        
    }
    return self;
}

-(void) goMenu {
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}
@end
