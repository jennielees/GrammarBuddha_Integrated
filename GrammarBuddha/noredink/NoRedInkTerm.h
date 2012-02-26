//
//  NoRedInkTerm.h
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    NoRedInkTermGenderMale = 1,
    NoRedInkTermGenderFemale = 2
} NoRedInkTermGender;

@interface NoRedInkTerm : NSObject
@property (nonatomic, assign) NSString *name;
@property (nonatomic) NSUInteger gender;

- (id) initWithName:(NSString*)name gender:(NSUInteger)gender;
+ (id) termWithName:(NSString*)name gender:(NSUInteger)gender;
@end
