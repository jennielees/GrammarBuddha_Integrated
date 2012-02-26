//
//  NoRedInkHTTPClient.h
//  Checklisted
//
//  Created by James Richard on 2/24/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "AFHTTPClient.h"

extern NSString * const NoRedInkBaseURL;

typedef enum {
    NoRedInkGroupApostrophes = 1,
    NoRedInkGroupSubjectVerbAgreement = 3,
    NoRedInkGroupCommasRunonsFragments = 4
} NoRedInkGroup;

@interface NoRedInkHTTPClient : AFHTTPClient

+ (NoRedInkHTTPClient*) sharedClient;
- (void) pullQuestionsWithGroup:(NSUInteger)group subgroups:(NSArray*)subgroups questions:(NSUInteger)questions 
                          terms:(NSArray*)terms exclusions:(NSArray*)exclusions 
                        success:(void(^)(AFHTTPRequestOperation *operation, NSArray* questions))success 
                        failure:(void(^)(AFHTTPRequestOperation *operation, NSError* error))failure;

- (void) pullQuestionsWithGroup:(NSUInteger)group subgroups:(NSArray*)subgroups questions:(NSUInteger)questions 
                     exclusions:(NSArray*)exclusions 
                        success:(void(^)(AFHTTPRequestOperation *operation, NSArray* questions))success 
                        failure:(void(^)(AFHTTPRequestOperation *operation, NSError* error))failure;
@end
