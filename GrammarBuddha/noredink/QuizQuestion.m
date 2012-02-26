//
//  QuizQuestion.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "QuizQuestion.h"
#import "GrammarQuestion.h"
#import "Quiz.h"


@implementation QuizQuestion

@dynamic answer;
@dynamic correctlyAnswered;
@dynamic answeredAt;
@dynamic createdAt;
@dynamic order;
@dynamic grammarQuestion;
@dynamic quiz;

// Answers the question, updating any metadata needed, and returns if it was correct or not
- (BOOL) answerQuestionWithSentence:(NSString*)sentence {
    self.answer = sentence;
    self.correctlyAnswered = [NSNumber numberWithBool:[self.grammarQuestion isCorrectWithSentence:sentence]];
    self.answeredAt = [NSDate date];
    
    return [self isCorrectlyAnswered];
}

- (BOOL) isCorrectlyAnswered {
    return [self.correctlyAnswered boolValue];
}

- (BOOL) isAnswered {
    return (self.answeredAt == nil) ? NO : YES;
}

// This returns a question for the user. 15 percent of the time it will be a correct sentence. The rest of the time, an incorrect sentence
- (NSString*) question {
    // We're only using incorrect sentences at this time
    /*if ((arc4random() % 100) < 15) {
        return [self.grammarQuestion aCorrectSentence];
    } else {
        return [self.grammarQuestion aIncorrectSentence];
    }*/
    
    return [self.grammarQuestion aIncorrectSentence];
}

@end
