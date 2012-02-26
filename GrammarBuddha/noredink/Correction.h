//
//  Correction.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CorrectionWord, GrammarQuestion;

@interface Correction : NSManagedObject

@property (nonatomic, retain) NSSet *correctionWords;
@property (nonatomic, retain) NSSet *grammarQuestions;

- (CorrectionWord*) randomCorrect;
- (CorrectionWord*) randomIncorrect;

- (NSArray*) corrects;
- (NSArray*) incorrects;
@end

@interface Correction (CoreDataGeneratedAccessors)

- (void)addCorrectionWordsObject:(CorrectionWord *)value;
- (void)removeCorrectionWordsObject:(CorrectionWord *)value;
- (void)addCorrectionWords:(NSSet *)values;
- (void)removeCorrectionWords:(NSSet *)values;

- (void)addGrammarQuestionsObject:(GrammarQuestion *)value;
- (void)removeGrammarQuestionsObject:(GrammarQuestion *)value;
- (void)addGrammarQuestions:(NSSet *)values;
- (void)removeGrammarQuestions:(NSSet *)values;

@end
