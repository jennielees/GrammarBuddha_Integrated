//
//  NoRedInkHTTPClient.m
//  Checklisted
//
//  Created by James Richard on 2/24/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "NoRedInkHTTPClient.h"
#import "RelevantTerm.h"
#import "GrammarQuestion.h"
#import "DataController.h"

NSString * const NoRedInkBaseURL = @"http://dev.noredink.com/";

@interface NoRedInkHTTPClient ()
- (id) initSingleton;
@end

@implementation NoRedInkHTTPClient


static NoRedInkHTTPClient *sNoRedInkHTTPClient;

- (id) init {
    NSAssert(NO, @"Cannot create instance of Singleton");
    
    return nil;
}

- (id) initSingleton {
    
    if ((self = [super initWithBaseURL:[NSURL URLWithString:NoRedInkBaseURL]])) {
        
    }
    
    return self;
}

+ (void) initialize {
    NSAssert(self == [NoRedInkHTTPClient class], @"Singleton is not designed to be subclassed.");
    sNoRedInkHTTPClient = [[[NoRedInkHTTPClient alloc] initSingleton] retain];
}

+ (NoRedInkHTTPClient*) sharedClient {
    if (!sNoRedInkHTTPClient)
        sNoRedInkHTTPClient = [[NoRedInkHTTPClient alloc] initSingleton];
    
    return sNoRedInkHTTPClient;
}

- (void) pullQuestionsWithGroup:(NSUInteger)group subgroups:(NSArray*)subgroups questions:(NSUInteger)questions 
                          terms:(NSArray*)terms exclusions:(NSArray*)exclusions 
                        success:(void(^)(AFHTTPRequestOperation *operation, NSArray* questions))success 
                        failure:(void(^)(AFHTTPRequestOperation *operation, NSError* error))failure {
    NSMutableArray *genders = [NSMutableArray array];
    NSMutableArray *names = [NSMutableArray array];
    
    [terms enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[RelevantTerm class]])
            NSAssert(NO, @"Name objects must be of class RelevantTerm");
        
        [genders addObject:((RelevantTerm*)obj).gender];
        [names addObject:((RelevantTerm*)obj).name];
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:[NSNumber numberWithInteger:questions] forKey:@"questions"];
    [params setValue:[NSNumber numberWithInteger:group] forKey:@"group"];
    [params setValue:names forKey:@"names"];
    [params setValue:genders forKey:@"genders"];
    
    if (subgroups != nil && subgroups.count > 0)
        [params setValue:subgroups forKey:@"subgroup"];
    
    if (exclusions != nil && exclusions.count > 0)
        [params setValue:exclusions forKey:@"exclude"];
    
    [self postPath:@"grammar_questions/generate" parameters:params success:^(AFHTTPRequestOperation* operation, id responseObject) {
        
        // -- THIS CODE SHOULD BE ON A SEPARATE THREAD
        [[DataController shared] markAllGrammarQuestionsUnusable];
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[(NSString*)responseObject dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        NSMutableArray *questionData = [NSMutableArray array];
        [[jsonDict objectForKey:@"questions"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [questionData addObject:[[DataController shared] createGrammarQuestionFromDict:obj]];
        }];
        [[DataController shared] saveContext];
        
        success(operation, [NSArray arrayWithArray:questionData]);
        // --- END; Keeping it here to get this process done quick.
        
    } failure:failure];
}

- (void) pullQuestionsWithGroup:(NSUInteger)group subgroups:(NSArray*)subgroups questions:(NSUInteger)questions 
                     exclusions:(NSArray*)exclusions 
                        success:(void(^)(AFHTTPRequestOperation *operation, NSArray* questions))success 
                        failure:(void(^)(AFHTTPRequestOperation *operation, NSError* error))failure {
    [self pullQuestionsWithGroup:group subgroups:subgroups questions:questions terms:[[DataController shared] relevantTerms] exclusions:exclusions success:success failure:failure];
    
}

- (void) dealloc {
    [sNoRedInkHTTPClient release];
    [super dealloc];
}

@end
