//
//  HelloWorldLayer.h
//  GrammarBuddhaMenu
//
//  Created by Anita Weil on 2/25/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameManager.h"

// HelloWorldLayer
@interface SelectLayer : CCLayer
{
    CCMenu *selectMenu;
    CCMenu *mainMenu;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
