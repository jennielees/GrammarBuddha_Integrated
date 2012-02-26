//
//  GrammarQuestion.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "GrammarQuestion.h"
#import "Correction.h"
#import "CorrectionWord.h"
#import "RegexKitLite.h"

@interface GrammarQuestion () 
- (NSString*) sentenceWithWordSubstitution:(NSString*)word;
@end


@implementation GrammarQuestion

@dynamic grammarQuestionID;
@dynamic sentence;
@dynamic code;
@dynamic codeID;
@dynamic subgroup;
@dynamic subgroupID;
@dynamic usable;
@dynamic correction;
@dynamic quizQuestions;

// This method returns whether an answer string is correct for this question. This is case-insensitive. This method should only be used for individual words, NOT sentence comparison. For that, use isCorrectWithSentence
- (BOOL) isCorrectWithAnswer:(NSString*)answer {
    __block BOOL isCorrect = NO;
    NSString *lowercasedAnswer = [answer lowercaseString];
    
    [self.correction.corrects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CorrectionWord *correctionWord = obj;
        if ([[correctionWord.word lowercaseString] isEqualToString:lowercasedAnswer]) {
            isCorrect = YES;
            *stop = YES;
        }
    }];
    
    return isCorrect;
}


// Use this function to compare a full sentence to all the possible correct sentence combinations of this question
- (BOOL) isCorrectWithSentence:(NSString*)answerSentence {
    __block BOOL isCorrect = NO;
    NSString *lowercasedAnswerSentence = [answerSentence lowercaseString];
    
    [self.correction.corrects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CorrectionWord *correctionWord = obj;
        NSString *substitutedSentence = [[self sentenceWithWordSubstitution:correctionWord.word] lowercaseString];
        
        if ([substitutedSentence isEqualToString:lowercasedAnswerSentence]) {
            isCorrect = YES;
            *stop = YES;
        }
    }];
    
    return isCorrect;
}

- (NSString*) aIncorrectSentence {
    return [self sentenceWithWordSubstitution:self.correction.randomIncorrect.word];
}

- (NSString*) aCorrectSentence {
    return [self sentenceWithWordSubstitution:self.correction.randomCorrect.word];
}

- (NSString*) sentenceWithWordSubstitution:(NSString*)word {
    NSRange range = [word rangeOfRegex:@"^[,\\.\\?]"];
    NSString *substitutedSentence;
    
    // If there's punctuation at the start of this word we want to also substitute the space in front of the grammar correction to avoid a malformed sentence
    if (range.location != NSNotFound) {
        substitutedSentence = [self.sentence stringByReplacingOccurrencesOfRegex:@" \\{GRAMMAR_CORRECTION\\}" withString:word];
    } else {
        substitutedSentence = [self.sentence stringByReplacingOccurrencesOfRegex:@"\\{GRAMMAR_CORRECTION\\}" withString:word];
    }
    
    return substitutedSentence;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"ID: %@, Subgroup: %@, Subgroup ID: %@, Code: %@, Code ID: %@, Sentence: %@, Correction: %@", 
            self.grammarQuestionID, self.subgroup, self.subgroupID, self.code, self.codeID, self.sentence, self.correction];
}

@end
