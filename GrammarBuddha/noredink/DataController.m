//
//  DataController.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "DataController.h"
#import "GrammarQuestion.h"
#import "Quiz.h"
#import "QuizQuestion.h"
#import "Correction.h"
#import "CorrectionWord.h"


@interface DataController ()
- (id) initSingleton;
- (Correction*) createCorrectionWithCorrects:(NSArray*)corrects incorrects:(NSArray*)incorrects;
- (CorrectionWord*) createCorrectionWord:(NSString*)word kind:(NoRedInkCorrectionWordKind)kind;
@end


@implementation DataController
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
static DataController *sDataController;

- (id) init {
    NSAssert(NO, @"Cannot create instance of Singleton");
    
    return nil;
}

- (id) initSingleton {
    if ((self = [super init])) {
        
    }
    
    return self;
}

+ (void) initialize {
    NSAssert(self == [DataController class], @"Singleton is not designed to be subclassed.");
    sDataController = [[DataController alloc] initSingleton];
}

+ (DataController*) shared {
    if (!sDataController)
        sDataController = [[[DataController alloc] initSingleton] retain];
    
    return sDataController;
}

/* 
 Marks all currently available grammar questions unavailable. 
 This should only be called before loading in new usable questions
 */
- (void) markAllGrammarQuestionsUnusable {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarQuestion"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"usable = %@", [NSNumber numberWithBool:YES]]];
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    // TODO: Add error checking
    
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((GrammarQuestion*)obj).usable = [NSNumber numberWithBool:NO];
    }];
    
    [self saveContext];
}

- (NSUInteger) numberOfGrammarQuestions {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarQuestion"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"usable = %@", [NSNumber numberWithBool:YES]]];
    NSError *error;
    return [self.managedObjectContext countForFetchRequest:request error:&error];
}

- (NSUInteger) numberOfRelevantTerms {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RelevantTerm"];
    NSError *error;
    return [self.managedObjectContext countForFetchRequest:request error:&error];
}

- (NSArray*) grammarQuestions {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarQuestion"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"usable = %@", [NSNumber numberWithBool:YES]]];
    NSError *error;
    return [self.managedObjectContext executeFetchRequest:request error:&error];
}

- (NSArray*) relevantTerms {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RelevantTerm"];
    NSError *error;
    return [self.managedObjectContext executeFetchRequest:request error:&error];
}

#pragma mark - Object creation helpers
- (Quiz*) createQuiz {
    Quiz *quiz = [[Quiz alloc] initWithEntity:
                  [NSEntityDescription entityForName:@"Quiz" inManagedObjectContext:self.managedObjectContext] 
               insertIntoManagedObjectContext:self.managedObjectContext];
    
    return quiz;
}
- (RelevantTerm*) createRelevantTermWithName:(NSString*)name gender:(RelevantTermGender)gender {
    RelevantTerm *relevantTerm = [[RelevantTerm alloc] initWithEntity:
                                  [NSEntityDescription entityForName:@"RelevantTerm" inManagedObjectContext:self.managedObjectContext] 
                                       insertIntoManagedObjectContext:self.managedObjectContext];
    
    relevantTerm.name = name;
    relevantTerm.gender = [NSNumber numberWithInteger:gender];
    
    return relevantTerm;
}

- (GrammarQuestion*) createGrammarQuestionFromDict:(NSDictionary*)dict {
    GrammarQuestion *grammarQuestion = [[GrammarQuestion alloc] initWithEntity:
                                        [NSEntityDescription entityForName:@"GrammarQuestion" inManagedObjectContext:self.managedObjectContext] 
                                                insertIntoManagedObjectContext:self.managedObjectContext];
    
    grammarQuestion.grammarQuestionID = [NSNumber numberWithInteger:[[dict objectForKey:@"grammar_question_id"] integerValue]];
    grammarQuestion.code = [NSNumber numberWithInteger:[[dict objectForKey:@"code"] integerValue]];
    grammarQuestion.codeID = [NSNumber numberWithInteger:[[dict objectForKey:@"code_id"] integerValue]];
    grammarQuestion.subgroup = [NSNumber numberWithInteger:[[dict objectForKey:@"subgroup"] integerValue]];
    grammarQuestion.subgroupID = [NSNumber numberWithInteger:[[dict objectForKey:@"subgroup_id"] integerValue]];
    grammarQuestion.sentence = [dict objectForKey:@"sentence"];
    grammarQuestion.usable = [NSNumber numberWithBool:YES];
    grammarQuestion.correction = [self createCorrectionWithCorrects:[[dict objectForKey:@"correction"] objectForKey:@"corrects"]
                                                         incorrects:[[dict objectForKey:@"correction"] objectForKey:@"incorrects"]];
    
    return grammarQuestion;
}

- (Correction*) createCorrectionWithCorrects:(NSArray*)corrects incorrects:(NSArray*)incorrects {
    Correction *correction = [[Correction alloc] initWithEntity:
                              [NSEntityDescription entityForName:@"Correction" inManagedObjectContext:self.managedObjectContext] 
                                 insertIntoManagedObjectContext:self.managedObjectContext];
    
    
    [corrects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CorrectionWord * correctionWord = [self createCorrectionWord:obj kind:NoRedInkCorrectionWordCorrect];
        [correction addCorrectionWordsObject:correctionWord];
    }];
    
    [incorrects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CorrectionWord * correctionWord = [self createCorrectionWord:obj kind:NoRedInkCorrectionWordIncorrect];
        [correction addCorrectionWordsObject:correctionWord];
    }];
    
    return correction;
}

- (CorrectionWord*) createCorrectionWord:(NSString*)word kind:(NoRedInkCorrectionWordKind)kind {
    CorrectionWord *correctionWord = [[CorrectionWord alloc] initWithEntity:
                                      [NSEntityDescription entityForName:@"CorrectionWord" inManagedObjectContext:self.managedObjectContext] 
                                             insertIntoManagedObjectContext:self.managedObjectContext];
    correctionWord.word = word;
    correctionWord.kind = [NSNumber numberWithInteger:kind];
    
    return correctionWord;
}

- (QuizQuestion*) appendNewQuizQuestionInQuiz:(Quiz*)quiz error:(NSError**)error {
    // Grab a list of questions currently not within this quiz
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"QuizQuestion"];
    
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:error];
    NSMutableArray *listOfIDs = [NSMutableArray array];
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [listOfIDs addObject:[[((QuizQuestion*)obj) grammarQuestion] grammarQuestionID]];
    }];
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarQuestion"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (grammarQuestionID in %@) AND usable = %@", listOfIDs, [NSNumber numberWithBool:YES]];
    [request setPredicate:predicate];
    
    NSUInteger remainingQuestions = [self.managedObjectContext countForFetchRequest:request error:error];
    
    if (remainingQuestions == 0) {
        *error = [NSError errorWithDomain:@"NotEnoughQuestions" code:1 userInfo:nil];
        return nil;;
    }
    
    request.fetchLimit = 1;
    request.fetchOffset = arc4random() % remainingQuestions;
    
    results = [self.managedObjectContext executeFetchRequest:request error:error];
    GrammarQuestion *grammarQuestion = [results objectAtIndex:0];
    QuizQuestion *quizQuestion = [[QuizQuestion alloc] initWithEntity:
                                  [NSEntityDescription entityForName:@"QuizQuestion" inManagedObjectContext:self.managedObjectContext] 
                                       insertIntoManagedObjectContext:self.managedObjectContext];
    
    quizQuestion.grammarQuestion = grammarQuestion;
    quizQuestion.quiz = quiz;
    
    return quizQuestion;
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GrammarBuddha" withExtension:@"mom"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GrammarBuddha.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

- (void)saveContextWithError:(NSError**)error {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges]) {
            [managedObjectContext save:error];   
        }
    }
}

// This call shouldn't be used in the application. Here only for testing purposes
- (void) resetStore {
    NSError * error;
    // retrieve the store URL
    NSURL * storeURL = [[self.managedObjectContext persistentStoreCoordinator] URLForPersistentStore:[[[self.managedObjectContext persistentStoreCoordinator] persistentStores] lastObject]];
    // lock the current context
    [self.managedObjectContext lock];
    [self.managedObjectContext reset];//to drop pending changes
    //delete the store from the current managedObjectContext
    if ([[self.managedObjectContext persistentStoreCoordinator] removePersistentStore:[[[self.managedObjectContext persistentStoreCoordinator] persistentStores] lastObject] error:&error])
    {
        // remove the file containing the data
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
        //recreate the store like in the  appDelegate method
        [[self.managedObjectContext persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];//recreates the persistent store
    }
    [self.managedObjectContext unlock];
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void) dealloc {
    [self.managedObjectContext release];
    [self.managedObjectModel release];
    [self.persistentStoreCoordinator release];
    [super dealloc];
}

@end
