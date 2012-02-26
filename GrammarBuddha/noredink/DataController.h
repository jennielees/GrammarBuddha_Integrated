//
//  DataController.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RelevantTerm.h"

@class GrammarQuestion;
@class RelevantTerm;
@class QuizQuestion;
@class Quiz;


@interface DataController : NSObject {
    
}
@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) markAllGrammarQuestionsUnusable;
- (NSUInteger) numberOfGrammarQuestions;
- (NSUInteger) numberOfRelevantTerms;
- (NSArray*) grammarQuestions;
- (NSArray*) relevantTerms;

- (GrammarQuestion*) createGrammarQuestionFromDict:(NSDictionary*)dict;
- (Quiz*) createQuiz;
- (RelevantTerm*) createRelevantTermWithName:(NSString*)name gender:(RelevantTermGender)gender;
- (QuizQuestion*) appendNewQuizQuestionInQuiz:(Quiz*)quiz error:(NSError**)error;

+ (DataController*) shared;
- (void)saveContext;
- (void)saveContextWithError:(NSError**)error;
- (NSURL *)applicationDocumentsDirectory;

- (void) resetStore;

@end
