//
//  HelloWorldLayer.m
//  Grammar
//
//  Created by Emmy Chen on 2/25/12.
//  Copyright Kuaitech 2012. All rights reserved.
//


// Import the interfaces
#import "Sentences.h"
#import "SimpleAudioEngine.h"
#import "GameConfig.h"
#import "Result.h"
#import "MainMenuLayer.h"
#import "GameManager.h"


static const CGPoint comPos[3] = {
    {200, 200}, {400, 200}, {600, 200},
};
BOOL res[5];

// HelloWorldLayer implementation
@implementation Sentences


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Sentences *layer = [Sentences node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void)  repostionSentence:(int)index {
    [[SimpleAudioEngine sharedEngine] playEffect:@"bubbleDropAudio.mp3"];

    int i = 0;
    int x = 100;
    float hightIndex[3] = {0.7, 0.4, 0.25};
    if(index == sentWordList.count-1) {
        CCLabelTTF *word = (CCLabelTTF*) [sentWordList objectAtIndex:index];
        x = word.position.x+selectedItem.contentSize.width/2+word.contentSize.width/2;
        selectedItem.position = ccp(x+sentenceBox.position.x-sentenceBox.contentSize.width/2, word.position.y);
    }  else {
        for(int j = 0; j < words[count].count; j++) {
            CCLabelTTF *word = (CCLabelTTF*) [sentWordList objectAtIndex:j];
            if(j !=0) {
                CCLabelTTF *wordPre = (CCLabelTTF*) [sentWordList objectAtIndex:j-1];
                x = x+12+wordPre.contentSize.width/2+word.contentSize.width/2;
            } else if(j==0)   // first word
                x = 100;
            if(x > sentenceBox.contentSize.width-100) {
                x = 100;
                i++;
            }
            word.position  = ccp(x+sentenceBox.position.x-sentenceBox.contentSize.width/2, sentenceBox.position.y-sentenceBox.contentSize.height/2+sentenceBox.contentSize.height*hightIndex[i]);
            if(index == j) {
                CCLabelTTF *wordNext = (CCLabelTTF *) [sentWordList objectAtIndex:j+1];
                if(word.position.y > wordNext.position.y)   {   // last word in the line
                    x = word.position.x+selectedItem.contentSize.width/2+word.contentSize.width/2;
                    selectedItem.position = ccp(x+sentenceBox.position.x-sentenceBox.contentSize.width/2, word.position.y);
                    
                } else {
                    
                    x = x+word.contentSize.width/2+selectedItem.contentSize.width/2;
                    selectedItem.position = ccp(x+sentenceBox.position.x-sentenceBox.contentSize.width/2, sentenceBox.position.y-sentenceBox.contentSize.height/2+sentenceBox.contentSize.height*hightIndex[i]);
                    CCLabelTTF *nextWord = (CCLabelTTF *)[sentWordList objectAtIndex:j+1];
                    x = x+12+selectedItem.contentSize.width/2+nextWord.contentSize.width/2;
                    if(x > sentenceBox.contentSize.width-100) {
                        x = 100;
                        i++;
                    }
                    nextWord.position = ccp(x+sentenceBox.position.x-sentenceBox.contentSize.width/2, sentenceBox.position.y-sentenceBox.contentSize.height/2+sentenceBox.contentSize.height*hightIndex[i]);
                     j++;
                }
               
            } 
            
        }
    }
    id delay = [CCDelayTime actionWithDuration: 1.0f];
    [[sentWordList objectAtIndex:0] runAction:[[delay copy] autorelease]];
}

-(void) displaySentence {
    int fontSize = 40; 
    float hightIndex[3] = {0.7, 0.4, 0.25};
    int i = 0;
    int x = 0;
    
    id moveAction = [CCMoveBy actionWithDuration:1.0f
                                        position:ccp(1500, 0)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:0.8f];
    
    for(int j = 0; j < words[count].count; j++) {
        CCLabelTTF *word = [CCLabelTTF labelWithString:[words[count] objectAtIndex:j] fontName:@"Arial" fontSize:fontSize];
        word.color = ccBLACK;
        if(j !=0) {
            CCLabelTTF *wordPre = [CCLabelTTF labelWithString:[words[count] objectAtIndex:j-1] fontName:@"Arial" fontSize:fontSize];
            x = x+12+wordPre.contentSize.width/2+word.contentSize.width/2;
        } else if(j==0){   // first word
            x = 100+word.contentSize.width/2;
        }
        
        if(x > sentenceBox.contentSize.width-100) {
            x = 100+word.contentSize.width/2;
            i++;
        }
        word.position  = ccp((x+sentenceBox.position.x-sentenceBox.contentSize.width/2-1500), sentenceBox.position.y-sentenceBox.contentSize.height/2+sentenceBox.contentSize.height*hightIndex[i]);
        //NSLog(@"hight %d = %f", i, sentenceBox.contentSize.height*hightIndex[i]);
        word.color = ccBLACK;
        
        // ANIMATE CODE
        [word runAction:[[moveEffect copy] autorelease]];
//        NSLog(@"Ran move effect");

        
        [self addChild:word];
        [sentWordList addObject:word];
        //[sentenceBox addChild:word z:1 tag:j];
    }
}

-(void) setupCommas {
    NSString *f[4] = {
      @"commaBubble.png", @"semiBubble.png", @"periodBubble.png",  
    };
    NSString *l[COMMAS_NUM] = {
      @",", @";", @".",  
    };
    for(int i = 0; i < COMMAS_NUM; i++) {
        commas[i] = [CCLabelTTF labelWithString:l[i] fontName:@"Helvetica-Bold" fontSize:60 ];
        CCSprite *bubble = [CCSprite spriteWithFile:f[i]];
        commas[i].color = ccBLACK;
        bubble.position = ccp(commas[i].contentSize.width/2, commas[i].contentSize.height/2);
        [commas[i] addChild:bubble z:-1 tag:8];
        commas[i].position = comPos[i];
        [self addChild:commas[i] z:500];
    }
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self = [super init])) {
        completedSent = 0;
        count = arc4random()%SENTENCES_NUM;
        
        NSError *error;
        quiz = [[DataController shared] createQuizWithQuestions:5 error:&error];
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *bg = [CCSprite spriteWithFile:@"backgroundGame.png"];
        bg.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:bg z:-10];
        NSArray *wordsArray[SENTENCES_NUM];
        for(int i = 0; i<SENTENCES_NUM; i++) {
            words[i] = [[NSMutableArray alloc] init];
        }
       sentWordList = [[NSMutableArray alloc] init];
        for(int i = 0; i < SENTENCES_NUM; i++) {
//            NSArray *wordsAndEmptyStrings = [sentenceList[i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     // JAMES CODE
            NSArray *wordsAndEmptyStrings = [[[quiz.quizQuestions objectAtIndex:i] question] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            wordsArray[i] = [[wordsAndEmptyStrings filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]] retain];
            NSLog(@"sentence %d = %@", i, words[i]);
        }
        for (int i = 0; i < SENTENCES_NUM; i++) {
            [words[i] setArray:wordsArray[i]];
        }
        sentenceBox = [CCSprite  spriteWithFile:@"textBlock.png"];
        sentenceBox.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:sentenceBox];
        
        [self displaySentence];
        [self setupCommas];
        
        CCMenuItemImage *forwordItem = [CCMenuItemImage itemFromNormalImage:@"forwardBtn.png" selectedImage:@"forwardBtn.png" target:self selector:@selector(goSentences:)];
        CCMenuItemImage *backwordItem = [CCMenuItemImage itemFromNormalImage:@"backBtn.png" selectedImage:@"backBtn.png" target:self selector:@selector(goSentences:)];
        forwordItem.tag = 0;
        backwordItem.tag = 1;
        forwordItem.position = ccp(winSize.width*2/3, 80);
        backwordItem.position = ccp(winSize.width/3, 80);
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"homeBtn.png" selectedImage:@"homeBtn.png" target:self selector:@selector(goMenu)];
        back.position= ccp(50, 50);
        CCMenu *menu = [CCMenu menuWithItems:forwordItem, backwordItem, back, nil];
        menu.position = ccp(0,0);
      //  [self addChild:menu];
//        [[SimpleAudioEngine sharedEngine] preloadEffect:@"wrongSound.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"bubbleDropAudio.mp3"];
        
        buddha = [CCSprite spriteWithFile:@"cloudBuddha.png"];
        buddha.position = ccp(winSize.width-(buddha.contentSize.width*0.6), winSize.height - buddha.contentSize.height*0.6);
        buddha.scaleX = 0.6;
        buddha.scaleY = 0.6;
        [self addChild:buddha z:10];

        
        CCSprite *cloud = [CCSprite spriteWithFile:@"goodScoreCloud.png"];
        cloud.position = ccp((winSize.width-(buddha.contentSize.width*0.6)-135), (winSize.height-60));

        [self addChild:cloud z:15];
        
        CCSprite *timerBack = [CCSprite spriteWithFile:@"timerBack.png"];
        timerBack.position = ccp(200, (winSize.height - timerBack.contentSize.height*0.5));
        
        [self addChild:timerBack z:15];

        // labels
        timerLabel = [CCLabelTTF labelWithString:@"0:00" fontName:@"Helvetica-Bold" fontSize:42 ];
        timerLabel.color = ccBLACK;
        timerLabel.position = ccp(200, (winSize.height + 30 - timerBack.contentSize.height*0.5));
        [self addChild:timerLabel z:55];
        
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica-Bold" fontSize:42];
        scoreLabel.color = ccBLACK;
        scoreLabel.position = ccp((winSize.width-260), (winSize.height-60));
        [self addChild:scoreLabel z:55];
        
        gameTimer=0;
        totalScore = 0;
        
        
        [self schedule:@selector(tick:) interval:1];//using zero for the interval will just sync us with the default refresh, usually every 1/60 second

        if ([GameManager sharedGameManager].isMultiplayerON) {
            // Put the multiplayer assets up 
            
            badBuddha = [CCSprite spriteWithFile:@"badBuddha.png"];
            badBuddha.position = ccp(winSize.width-(buddha.contentSize.width*0.6),buddha.contentSize.height*0.6);
            badBuddha.scaleX = 0.6;
            badBuddha.scaleY = 0.6;
            [self addChild:badBuddha z:10];
            
            
            CCSprite *badCloud = [CCSprite spriteWithFile:@"badScoreCloud.png"];
            badCloud.position = ccp((winSize.width-(buddha.contentSize.width*0.6)-135), 60);
            
            [self addChild:badCloud z:15];
            
            badScoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica-Bold" fontSize:42];
            badScoreLabel.color = ccBLACK;
            badScoreLabel.position = ccp((winSize.width-260), 60);
            [self addChild:badScoreLabel z:55];
                
        }
        
        self.isTouchEnabled = YES;
	}
	return self;
}
-(void) goMenu {
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

-(void) goSentences:(CCNode *)sender {
    for(int i= 0; i < 3;i++) {
        CCSprite *b = (CCSprite*)[commas[i] getChildByTag:8];
        [b setVisible:YES];
        [commas[i] setVisible:YES];
        commas[i].position = comPos[i];
        commas[i].tag = i;
    }
    for (int i = 0; i< sentWordList.count; i++) {
        CCLabelTTF *word = (CCLabelTTF*) [sentWordList objectAtIndex:i];
        [word removeFromParentAndCleanup:YES];
    }
    [sentWordList removeAllObjects];
    //[sentenceBox removeAllChildrenWithCleanup:YES];
    if(sender.tag == 0) {
        if(count == SENTENCES_NUM-1) count = 0;
        else count++;
    } else if(sender.tag == 1) {
        if(count == 0) count = SENTENCES_NUM-1;
        else 
        count--;
    }
    //NSLog(@"count %d", count);
    [self displaySentence];
}

-(void) goSentences2 {
    for(int i= 0; i < 3;i++) {
        CCSprite *b = (CCSprite*)[commas[i] getChildByTag:8];
        [b setVisible:YES];
        [commas[i] setVisible:YES];
        commas[i].position = comPos[i];
        commas[i].tag = i;
    }
    for (int i = 0; i< sentWordList.count; i++) {
        CCLabelTTF *word = (CCLabelTTF*) [sentWordList objectAtIndex:i];
        [word removeFromParentAndCleanup:YES];
    }
    [sentWordList removeAllObjects];
    if(count == SENTENCES_NUM-1) count = 0; 
    else count++;
    //NSLog(@"count %d", count);
    [self displaySentence];
}

-(void) changeBlack:(CCLabelTTF *) node {
    node.color = ccBLACK;
}
-(void) changeColor:(CCLabelTTF *)node {
    node.color = ccRED;
    [self performSelector:@selector(changeBlack:) withObject:node afterDelay:0.8];
}
-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
- (BOOL)selectSpriteForTouch:(UITouch*)touch {
    BOOL selected = NO;
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    for(int i = 0; i < COMMAS_NUM; i++) {
        if(CGRectContainsPoint(commas[i].boundingBox, touchLocation) && commas[i].tag != 888) {
            selectedItem = commas[i];
            orgPos = comPos[i];
            selected = YES;
            break;
        }
    }
    return selected;
}

// BEGIN CHANGED GESTURE CODE

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    firstTouch = touchLocation;
    
    // Is it a sprite?
	BOOL tc = NO;
    if([self selectSpriteForTouch:touch]) 
        tc = YES;
    
    // Ok, are we selecting a word or swiping in the word area?
    if (firstTouch.y > 300 && firstTouch.y < 500) {
        tc = YES; // continue to logic in the next part to figure out quite what we did
        selectedItem = nil; // A wee hack to deselect any 'floating' punctuation
    }
    return tc;
}
// END CHANGED GESTURE CODE


- (void)panForTranslation:(CGPoint)translation {    
    if (selectedItem && selectedItem.tag != 888) {
        CGPoint newPos = ccpAdd(selectedItem.position, translation);
        selectedItem.position = newPos;
    }  
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
	
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
	
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
    [self panForTranslation:translation];   
}

-(BOOL) check:(int) index {
    BOOL right = NO;
    CCLabelTTF *word1  = (CCLabelTTF*) [sentWordList objectAtIndex:index];
    CGPoint pos1 = word1.position;
    assert(word1);

    CGRect dropArea;

    if(index == words[count].count-1) { // last word
        dropArea = CGRectMake(pos1.x+word1.contentSize.width/2-10, pos1.y-word1.contentSize.height/2-5, 40, 40);
    } else {
        CCLabelTTF *word2 = (CCLabelTTF*) [sentWordList objectAtIndex:index+1];
        CGPoint pos2 = word2.position;
        float x = (pos2.x-pos1.x)/2-10;
        float y = pos1.y-word1.contentSize.height/2-5;
        dropArea = CGRectMake(x, y, 40, 40);
    }
   // dropArea.origin = CGPointZero;

    if(CGRectContainsRect(dropArea, selectedItem.boundingBox)) {
        NSLog(@"RIGHT");
        right = YES; 
    }
    return  right;
}

-(void) playSound:(NSString*) sound {
    [[SimpleAudioEngine sharedEngine] playEffect:sound];
}
-(void) gotoResult {
    [GameManager sharedGameManager].latestScore = totalScore;  
    [[CCDirector sharedDirector] replaceScene:[Result scene]];
}
-(void) playResult:(CCSprite *) result {
    CGSize winSize = [CCDirector sharedDirector].winSize;

 //   id rotate = [CCRotateBy actionWithDuration:1 angle:-50];
   // id rotateBk = [rotate reverse];
  //  id seq = [CCSequence actions:rotate, rotateBk, nil];
 //   id blink = [CCBlink actionWithDuration:2 blinks:3];
    //id spawn1 = [CCSpawn actions: blink, nil];
    if (result) {
        id move = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width-200, winSize.height-70)];
        id feadout = [CCScaleTo actionWithDuration:1 scale:0.2];
        id spawn = [CCSpawn actions:move, feadout, nil];
        id remove3 = [CCCallFuncND actionWithTarget:result  selector:@selector(removeFromParentAndCleanup:) data:(void*)YES];
        [result runAction:[CCSequence actions:spawn, remove3, nil]];
    }
    // Removed code to display the checkmark, now we are going to update the score
    
    [scoreLabel setString:[NSString stringWithFormat:@"%d",totalScore]];
    NSLog(@"Completed %d", completedSent);
    if(completedSent==SENTENCES_NUM) {
        [self performSelector:@selector(gotoResult) withObject:nil afterDelay:1];
    } else {
        [self performSelector:@selector(goSentences2) withObject:nil afterDelay:1];
    }
}

-(BOOL) checkAnswer:(NSString*) submit {
    BOOL result = NO;
    NSLog(@"submit: %@", submit);
   // NSLog(@"answer: %@", (NSString*)rightSentenceList[count]);
   // if([submit isEqualToString:(NSString*)rightSentenceList[count]]) {
   //     result = YES;
   // };
    
    result = YES; // [[quiz.quizQuestions objectAtIndex:count] answerQuestionWithSentence:submit];

    return result;
}

-(void) goSubmit {
    
    NSLog(@"Submit called");
    completedSent++;
    count++;
    if (count == SENTENCES_NUM) { 
        count = 0;
    }
    
    NSString *sentence = [NSString stringWithString:@""];;
    for(int i = 0; i < sentWordList.count; i++) {
        CCLabelTTF *label = [sentWordList objectAtIndex:i];
        if(i==0) {
            sentence = [sentence stringByAppendingFormat:@"%@", label.string];
        } else {
            if(insertIndex==i-1)  sentence = [sentence stringByAppendingFormat:@" %@", selectedItem.string];
            sentence = [sentence stringByAppendingFormat:@" %@", label.string];
        }
        
    }
    
    NSLog(@"sentence \n %@", sentence);
    if([self checkAnswer:sentence]) {
        res[completedSent] = YES;
        buddha.scaleX=0.6 + completedSent*0.1;
        buddha.scaleY=0.6 + completedSent*0.1;
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *rightSprite = [CCSprite spriteWithFile:@"oneHundredPoints.png"];
        rightSprite.position = ccp(winSize.height/2, winSize.width/2);
        [self addChild:rightSprite z:20000];
        [self performSelector:@selector(playResult:) withObject:rightSprite afterDelay:1];
        totalScore += 100;

        
    }
    else {
        res[completedSent] = NO;
        [self playResult:nil];
    }
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        id moveAction = [CCMoveBy actionWithDuration:1.0f
                                            position:ccp(-1500, 0)];
        id moveEffect = [CCEaseIn actionWithAction:moveAction rate:0.8f];
        
        for(int i = 0;i < words[count].count; i++) {
            CCLabelTTF *word1 = [sentWordList objectAtIndex:i];
            
            // ANIMATE CODE
            [word1 runAction:[[moveEffect copy] autorelease]];
            
            //    NSLog(@"Ran move effect");
            
        }
        [selectedItem runAction:[[moveEffect copy] autorelease]];
        
        
    });
    
    
}



// BEGIN CHANGED GESTURE CODE
// This removed from touch and made into its own function.
-(void) checkSentenceAndIncrement:(int) i {
 //   BOOL right = NO;
    NSLog(@"CHECK");
    // was punc added?
    if (selectedItem) {
        
        selectedItem.tag = 888;
        CCSprite *b = (CCSprite*) [selectedItem getChildByTag:8];
        assert(b);
        [b setVisible:NO];
        [self repostionSentence:i];
    }
   // right = YES;
    
    
    //BOOL correct = [[quiz.quizQuestions objectAtIndex:count] answerQuestionWithSentence:"asdf"];
  //  [self goSubmit];
    // should check the right or wrong
    // res[completedSent] = TRUE;
    //  CGSize winSize = [CCDirector sharedDirector].winSize;
    // CCSprite *rightSprite = [CCSprite spriteWithFile:@"oneHundredPoints.png"];
    // rightSprite.position = ccp(winSize.height/2, winSize.width/2);
    // [self addChild:rightSprite z:20000];
    // [self performSelector:@selector(playResult:) withObject:rightSprite afterDelay:1];
    //completedSent++;
    // buddha.scaleX=0.6 + completedSent*0.1;

}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];

    lastTouch = touchLocation;
    
    // Is it a swipe?
    
    //Minimum length of the swipe
    float swipeLength = ccpDistance(firstTouch, lastTouch);
    NSLog(@"Swipe length: %f", swipeLength);
    //Check if the swipe is a left swipe and long enough
  //  NSLog(@"firstTouch.y: %f", firstTouch.y);
  //  NSLog(@"firstTouch.y: %f", firstTouch.x);
  //  NSLog(@"lastTouch.y: %f", lastTouch.x);
  //  NSLog(@"lastTouch.y: %f", lastTouch.y);
    
    double delayInSeconds = 1.0;
    
    if (firstTouch.y < 500 && firstTouch.y > 300 && firstTouch.x > lastTouch.x && swipeLength > 200) {
        // Call next Sentence
        NSLog(@"Detected a swipe over 200");
       
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self goSubmit];

        });
              
        
        return;
    } 
    
    NSLog(@"It's not a swipe");
        // If not -- is it a word?
        
    for(int i = 0; i < words[count].count; i++) {
        CCLabelTTF *word = (CCLabelTTF*) [sentWordList objectAtIndex:i];
        if(CGRectContainsPoint(word.boundingBox, touchLocation)) {
            word.color = ccRED;
            [self performSelector:@selector(changeBlack:) withObject:word afterDelay:0.8];
            break;
        }
    } 
     // end is it a word?
    
    
    if(selectedItem) {   
        for(int i = 0;i < words[count].count; i++) {
            CCLabelTTF *word1 = [sentWordList objectAtIndex:i];
            CGPoint pos1 = word1.position;
            assert(word1);
            CGRect dropArea;
            if(i == words[count].count-1) { // last word
                dropArea = CGRectMake(pos1.x+word1.contentSize.width/2-20, pos1.y-word1.contentSize.height/2-20, 60, 60);
            } else {
                CCLabelTTF *word2 = (CCLabelTTF*) [sentWordList objectAtIndex:i+1];
                float x, y;
                if(word1.position.y > word2.position.y) {  // last word in the line
                    x = word1.position.x+word1.contentSize.width/2-20;
                    y = word1.position.y-word1.contentSize.height/2-20;
                } else {
                    //x = pos1.x+(pos2.x-pos1.x)/2-20;
                    x = pos1.x+word1.contentSize.width/2 -20;
                    y = pos1.y-30;
                }
                dropArea = CGRectMake(x, y, 60, 60);
            }
            
            if(CGRectContainsPoint(dropArea, touchLocation)) {
                insertIndex=i;
                
                [self checkSentenceAndIncrement:i];
                
                
                              // this checking needs cleanup!
                break;            
            } else {
                selectedItem.position = orgPos;
            }
         }
    }
}
// END CHANGED GESTURE CODE

- (void)tick:(ccTime)dt {
    gameTimer++;
    //NSLog(@"Ticking tick tick");
    int totalMins = gameTimer/60;
    int totalSecs = gameTimer-(totalMins*60);
    if (totalSecs < 10) {
        [timerLabel setString:[NSString stringWithFormat:@"%d:0%d",totalMins,totalSecs]];
    } else {
        [timerLabel setString:[NSString stringWithFormat:@"%d:%d",totalMins,totalSecs]];
    }
    
    // enemy scored!
    if (gameTimer == 4) {
        [badScoreLabel setString:@"100"];
        badBuddha.scaleX = 0.7;
        badBuddha.scaleY = 0.7;
    }
    
    if (gameTimer == 9) {
        [badScoreLabel setString:@"200"];
        badBuddha.scaleX = 0.8;
        badBuddha.scaleY = 0.8;
    }
    
    if (gameTimer == 14) {
        [badScoreLabel setString:@"300"];
        badBuddha.scaleX = 0.9;
        badBuddha.scaleY = 0.9;
    }
    
   // timeElapsed = ticker/frameRate;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [sentWordList release];
    sentWordList = nil;
	[super dealloc];
}
@end
