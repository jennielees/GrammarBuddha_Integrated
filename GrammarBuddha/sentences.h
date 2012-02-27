//
//  HelloWorldLayer.h
//  Grammar
//
//  Created by Emmy Chen on 2/25/12.
//  Copyright Kuaitech 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameConfig.h"
#import "DataController.h"
#import "Quiz.h"
#import "QuizQuestion.h"

// HelloWorldLayer
@interface Sentences : CCLayer
{
    int count;
    NSMutableArray *words[SENTENCES_NUM];
    NSMutableArray *sentWordList;
    CCSprite *sentenceBox, *buddha, *badBuddha;
    CCSprite *commas[COMMAS_NUM];
    CCLabelTTF *selectedItem;
    int completedSent;
    CGPoint orgPos;
    Quiz *quiz;
    
    NSMutableArray *questions;
    NSString *answer[SENTENCES_NUM];
    int insertIndex;

    
    int totalScore;
    int gameTimer;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *badScoreLabel;
    CCLabelTTF *timerLabel;
    
    // -- for swiping
    CGPoint firstTouch;
    CGPoint lastTouch;
    // -- end for swiping
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
