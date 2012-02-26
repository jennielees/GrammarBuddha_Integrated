//
//  RelevantTerm.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    RelevantTermGenderMale = 1,
    RelevantTermGenderFemale = 2
} RelevantTermGender;

@interface RelevantTerm : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * gender;

@end
