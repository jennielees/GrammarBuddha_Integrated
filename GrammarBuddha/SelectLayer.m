//
//  HelloWorldLayer.m
//  GrammarBuddhaMenu
//
//  Created by Anita Weil on 2/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "SelectLayer.h"
#import "CustomCCNode.h"

// HelloWorldLayer implementation
@implementation SelectLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SelectLayer *layer = [SelectLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void)displaySelectMenu {
    
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    
    id moveAction = [CCMoveBy actionWithDuration:1.0f
										position:ccp(screenSize.width, 0)];
	id moveEffect = [CCEaseIn actionWithAction:moveAction rate:0.8f];
 
	// Select Category Menu
    
    CustomCCNode *hpNode = [CustomCCNode spriteWithFile:@"hp200.png"];
    hpNode.position = ccp(137-screenSize.width,screenSize.height * 0.65f);
    hpNode.tag = 1;
    
    CustomCCNode *hpNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    hpNodeShadow.position = ccp(137,screenSize.height*0.65f);
    hpNodeShadow.opacity = 0;
    hpNode.linkedNode = hpNodeShadow; // The node that will toggle opacity when parent node is pressed
    [hpNode runAction:[[moveEffect copy] autorelease]];
    
    CustomCCNode *twilightNode = [CustomCCNode spriteWithFile:@"twilight200.png"];
    twilightNode.position = ccp(387-screenSize.width,screenSize.height * 0.65f);
    twilightNode.tag = 2;
    [twilightNode runAction:[[moveEffect copy] autorelease]];

    CustomCCNode *twNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    twNodeShadow.position = ccp(387,screenSize.height*0.65f);
    twNodeShadow.opacity = 0;
    twilightNode.linkedNode = twNodeShadow;
    
//    Glee is hardcoded as locked
//    CustomCCNode *glNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
//    glNodeShadow.position = ccp(600,screenSize.height*0.65f);
//    glNodeShadow.opacity = 0;
//    gleeNode.linkedNode = glNodeShadow;
    
    
    CustomCCNode *hungerNode = [CustomCCNode spriteWithFile:@"hunger_games.png"];
    hungerNode.position = ccp(637-screenSize.width,screenSize.height * 0.65f);
    hungerNode.tag = 3;
    [hungerNode runAction:[[moveEffect copy] autorelease]];
    
    CustomCCNode *huNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    huNodeShadow.position = ccp(637,screenSize.height*0.65f);
    huNodeShadow.opacity = 0;
    hungerNode.linkedNode = huNodeShadow;
    
    CustomCCNode *gleeNode = [CustomCCNode spriteWithFile:@"glee200locked.png"];
    gleeNode.position = ccp(887-screenSize.width,screenSize.height * 0.65f);
    gleeNode.tag = 4;
    [gleeNode runAction:moveEffect];
    
    
    [self addChild:hpNode z:100];
    [self addChild:hpNodeShadow z:1];
    [self addChild:twilightNode z:100];
    [self addChild:twNodeShadow z:1];
    [self addChild:gleeNode z:100];    
//    [self addChild:glNodeShadow z:1];
    [self addChild:hungerNode z:100];
    [self addChild:huNodeShadow z:1];

    // ROW 2
    CustomCCNode *nflNode = [CustomCCNode spriteWithFile:@"nfl.png"];
    nflNode.position = ccp(137-screenSize.width,screenSize.height * 0.35f);
    nflNode.tag = 5;
    
    CustomCCNode *nflNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    nflNodeShadow.position = ccp(137,screenSize.height*0.35f);
    nflNodeShadow.opacity = 0;
    nflNode.linkedNode = nflNodeShadow; // The node that will toggle opacity when parent node is pressed
    [nflNode runAction:[[moveEffect copy] autorelease]];
    
    CustomCCNode *disneyNode = [CustomCCNode spriteWithFile:@"disney_characters.png"];
    disneyNode.position = ccp(387-screenSize.width,screenSize.height * 0.35f);
    disneyNode.tag = 6;
    [disneyNode runAction:[[moveEffect copy] autorelease]];
    
    CustomCCNode *disNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    disNodeShadow.position = ccp(387,screenSize.height*0.35f);
    disNodeShadow.opacity = 0;
    disneyNode.linkedNode = disNodeShadow;

    CustomCCNode *superNode = [CustomCCNode spriteWithFile:@"superheroes.png"];
    superNode.position = ccp(637-screenSize.width,screenSize.height * 0.35f);
    superNode.tag = 7;
    [superNode runAction:[[moveEffect copy] autorelease]];
    
    CustomCCNode *superNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    superNodeShadow.position = ccp(637,screenSize.height*0.35f);
    superNodeShadow.opacity = 0;
    superNode.linkedNode = superNodeShadow;
    
    CustomCCNode *presidentNode = [CustomCCNode spriteWithFile:@"us_presidents.png"];
    presidentNode.position = ccp(887-screenSize.width,screenSize.height * 0.35f);
    presidentNode.tag = 8;
    [presidentNode runAction:[[moveEffect copy] autorelease]];
    
    CustomCCNode *presidentNodeShadow = [CustomCCNode spriteWithFile:@"glow200.png"];
    presidentNodeShadow.position = ccp(887,screenSize.height*0.35f);
    presidentNodeShadow.opacity = 0;
    presidentNode.linkedNode = presidentNodeShadow;
    
    [self addChild:nflNode z:100];
    [self addChild:nflNodeShadow z:1];
    [self addChild:disneyNode z:100];
    [self addChild:disNodeShadow z:1];
    [self addChild:superNode z:100];
    [self addChild:superNodeShadow z:1];
    [self addChild:presidentNode z:100];
    [self addChild:presidentNodeShadow z:1];

    
    
    self.isTouchEnabled = YES;
    
    // Title
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Pick your category" fontName:@"Last Ninja" fontSize:42];
    titleLabel.position = ccp(screenSize.width/2, (screenSize.height*0.9f+500));
    
    id moveVerticalAction = [CCMoveBy actionWithDuration:1.0f
										position:ccp(0, -500)];
	id moveVerticalEffect = [CCEaseIn actionWithAction:moveVerticalAction rate:0.8f];
    [titleLabel runAction:moveVerticalEffect];
    
    [self addChild:titleLabel];
    
    
    CCLabelTTF *continueLabel = [CCLabelTTF labelWithString:@"Go!" fontName:@"Last Ninja" fontSize:60];
    CCMenuItemLabel *continueButtonLabel = [CCMenuItemLabel itemWithLabel:continueLabel target:self selector:@selector(continueGame)];
    //titleLabel.position = ccp(screenSize.width/2, screenSize.height*0.9f);
    //[self addChild:titleLabel];
    
	mainMenu = [CCMenu menuWithItems:continueButtonLabel,nil];
	[mainMenu setPosition: ccp(screenSize.width/2, screenSize.height*0.1f)];
    mainMenu.opacity = 0;
    // delay showing the GO button for a little while
    id showAction = [CCShow action];
    id delayAction = [CCDelayTime actionWithDuration:2.0f];
    id fadeAction = [CCFadeIn actionWithDuration:0.4f];
    
    [mainMenu runAction: [CCSequence actions:delayAction, fadeAction, showAction, nil]];
    
	[self addChild:mainMenu];
    
    	
}

-(void) continueGame {
    
    // Update the list of categories
    for (CCNode *child in self.children) {
        if ([child isKindOfClass:[CustomCCNode class]]) {
            if ([child isSelected] == YES) {
                NSLog(@"%d tag", [child tag]);
                NSLog(@"Selected");
            }
        }
    }
    
    // will dispatch game mode
    [[GameManager sharedGameManager] runSceneWithID:kArcadeScene];

}

-(void) chooseCat:(CCMenuItemImage *)whichImage {
    // not yet implemented
    int cat = whichImage.tag;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        if (self!= nil) {
            CGSize screenSize = [CCDirector sharedDirector].winSize;		
            CCSprite *background = [CCSprite spriteWithFile:@"buddha_muted.png"];
            [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [self addChild:background];
            [self displaySelectMenu];
            
        }
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
