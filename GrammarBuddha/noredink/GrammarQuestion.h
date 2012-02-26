//
//  GrammarQuestion.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Correction;
@class QuizQuestion;

@interface GrammarQuestion : NSManagedObject

@property (nonatomic, retain) NSNumber * grammarQuestionID;
@property (nonatomic, retain) NSString * sentence;
@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSNumber * codeID;
@property (nonatomic, retain) NSNumber * subgroup;
@property (nonatomic, retain) NSNumber * subgroupID;
@property (nonatomic, retain) NSNumber * usable;
@property (nonatomic, retain) Correction *correction;
@property (nonatomic, retain) NSSet *quizQuestions;

- (BOOL) isCorrectWithAnswer:(NSString*)answer;
- (BOOL) isCorrectWithSentence:(NSString*)answerSentence;
- (NSString*) aIncorrectSentence;
- (NSString*) aCorrectSentence;

@end


@interface GrammarQuestion (CoreDataGeneratedAccessors)

- (void)addQuizQuestionsObject:(QuizQuestion *)value;
- (void)removeQuizQuestionsObject:(QuizQuestion *)value;
- (void)addQuizQuestions:(NSSet *)values;
- (void)removeQuizQuestions:(NSSet *)values;


@end
