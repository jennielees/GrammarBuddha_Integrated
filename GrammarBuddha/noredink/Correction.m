//
//  Correction.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "Correction.h"
#import "CorrectionWord.h"
#import "GrammarQuestion.h"

@interface Correction ()
- (CorrectionWord*) randomWordInArray:(NSArray*)aArray;
@end

@implementation Correction

@dynamic correctionWords;
@dynamic grammarQuestions;

- (NSArray*) corrects {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CorrectionWord"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"correction = %@ AND kind = %i", self, NoRedInkCorrectionWordCorrect]];
    // TODO: Error handling
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    return results;
}

- (NSArray*) incorrects {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CorrectionWord"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"correction = %@ AND kind = %i", self, NoRedInkCorrectionWordIncorrect]];
    // TODO: Error handling
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    return results;
}

- (CorrectionWord*) randomCorrect {
    return [self randomWordInArray:self.corrects];
}

- (CorrectionWord*) randomIncorrect {
    return [self randomWordInArray:self.incorrects];
}

- (CorrectionWord*) randomWordInArray:(NSArray*)aArray {
    NSUInteger index = arc4random() % aArray.count;
    return [aArray objectAtIndex:index];
}

@end
