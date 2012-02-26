//
//  QuizQuestion.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GrammarQuestion, Quiz;

@interface QuizQuestion : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSNumber * correctlyAnswered;
@property (nonatomic, retain) NSDate * answeredAt;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) GrammarQuestion *grammarQuestion;
@property (nonatomic, retain) Quiz *quiz;


- (BOOL) answerQuestionWithSentence:(NSString*)sentence;
- (BOOL) isCorrectlyAnswered;
- (BOOL) isAnswered;
- (NSString*) question;
@end
