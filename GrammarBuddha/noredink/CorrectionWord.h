//
//  CorrectionWord.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    NoRedInkCorrectionWordCorrect = 1,
    NoRedInkCorrectionWordIncorrect = 2,
    NoRedInkCorrectionWordNonorrect = 3
} NoRedInkCorrectionWordKind;

@class Correction;

@interface CorrectionWord : NSManagedObject

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSNumber * kind;
@property (nonatomic, retain) Correction *correction;

@end
