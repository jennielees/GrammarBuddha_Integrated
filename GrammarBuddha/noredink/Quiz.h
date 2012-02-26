//
//  Quiz.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QuizQuestion;

@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSDate * startedAt;
@property (nonatomic, retain) NSDate * finishedAt;
@property (nonatomic, retain) NSNumber * secondsRemaining;
@property (nonatomic, retain) NSOrderedSet *quizQuestions;

- (QuizQuestion*) appendNewQuizQuestionWithError:(NSError**)error;
- (QuizQuestion*) appendNewQuizQuestion:(NSError**)error;
- (NSUInteger) numberOfQuestionsAnsweredCorrectly;
- (NSUInteger) numberOfQuestionsAnsweredIncorrectly;
- (NSUInteger) numberOfQuestionsAnswered;
@end

@interface Quiz (CoreDataGeneratedAccessors)

- (void)insertObject:(QuizQuestion *)value inQuizQuestionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromQuizQuestionsAtIndex:(NSUInteger)idx;
- (void)insertQuizQuestions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeQuizQuestionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInQuizQuestionsAtIndex:(NSUInteger)idx withObject:(QuizQuestion *)value;
- (void)replaceQuizQuestionsAtIndexes:(NSIndexSet *)indexes withQuizQuestions:(NSArray *)values;
- (void)addQuizQuestionsObject:(QuizQuestion *)value;
- (void)removeQuizQuestionsObject:(QuizQuestion *)value;
- (void)addQuizQuestions:(NSOrderedSet *)values;
- (void)removeQuizQuestions:(NSOrderedSet *)values;
@end
