//
//  Quiz.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "Quiz.h"
#import "QuizQuestion.h"
#import "GrammarQuestion.h"

@implementation Quiz

@dynamic startedAt;
@dynamic finishedAt;
@dynamic secondsRemaining;
@dynamic quizQuestions;

// Leaving this function for now, but it shouldn't be used as the name didn't fit right
- (QuizQuestion*) appendNewQuizQuestionWithError:(NSError**)error {
    return [self appendNewQuizQuestion:error];
}

- (QuizQuestion*) appendNewQuizQuestion:(NSError**)error {
    // Grab a list of questions currently used
    
    /* We're only going to limit to questions not used in this quiz since during demo we want 
     the same questions to be seen more than once so the quiz can be built more than once
     
     NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"QuizQuestion"];
     
     
     NSArray *results = [self.managedObjectContext executeFetchRequest:request error:error];
     NSMutableArray *listOfIDs = [NSMutableArray array];
     [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
     [listOfIDs addObject:[[((QuizQuestion*)obj) grammarQuestion] grammarQuestionID]];
     }];*/
    
    NSMutableArray *listOfIDs = [NSMutableArray array];
    [self.quizQuestions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [listOfIDs addObject:[[((QuizQuestion*)obj) grammarQuestion] grammarQuestionID]];
    }];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarQuestion"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (grammarQuestionID in %@) AND usable = %@", listOfIDs, [NSNumber numberWithBool:YES]];
    [request setPredicate:predicate];
    
    NSUInteger remainingQuestions = [self.managedObjectContext countForFetchRequest:request error:error];
    
    if (remainingQuestions == 0) {
        *error = [[NSError errorWithDomain:@"NotEnoughQuestions" code:1 userInfo:nil] autorelease];
        return nil;
    }
    
    request.fetchLimit = 1;
    request.fetchOffset = arc4random() % remainingQuestions;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:error];
    GrammarQuestion *grammarQuestion = [results objectAtIndex:0];
    QuizQuestion *quizQuestion = [[QuizQuestion alloc] initWithEntity:
                                  [NSEntityDescription entityForName:@"QuizQuestion" inManagedObjectContext:self.managedObjectContext] 
                                       insertIntoManagedObjectContext:self.managedObjectContext];
    
    quizQuestion.grammarQuestion = grammarQuestion;
    quizQuestion.createdAt = [NSDate date];
    
    [self addQuizQuestionsObject:quizQuestion];
    *error = nil;
    
    return quizQuestion;
}

- (NSUInteger) numberOfQuestionsAnsweredCorrectly {
    __block NSUInteger answeredCorrectly = 0;
    [self.quizQuestions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuizQuestion *quizQuestion = obj;
        if (quizQuestion.isAnswered && quizQuestion.isCorrectlyAnswered)
            answeredCorrectly++;
    }];
    
    return answeredCorrectly;
}

- (NSUInteger) numberOfQuestionsAnsweredIncorrectly {
    __block NSUInteger answeredIncorrectly = 0;
    [self.quizQuestions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuizQuestion *quizQuestion = obj;
        if (quizQuestion.isAnswered && !quizQuestion.isCorrectlyAnswered)
            answeredIncorrectly++;
    }];
    
    return answeredIncorrectly;
}

- (NSUInteger) numberOfQuestionsAnswered {
    __block NSUInteger answered = 0;
    [self.quizQuestions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuizQuestion *quizQuestion = obj;
        if (quizQuestion.isAnswered)
            answered++;
    }];
    
    return answered;
}


// REMOVE THIS AFTER APPLE FIXES BUG
- (void)addQuizQuestionsObject:(QuizQuestion *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.quizQuestions];
    [tempSet addObject:value];
    self.quizQuestions = tempSet;
}

@end
