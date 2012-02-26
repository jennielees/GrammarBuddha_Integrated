//
//  NoRedInkTerm.m
//  GrammarBuddha
//
//  Created by James Richard on 2/25/12.
//  Copyright (c) 2012 LucidCoding. All rights reserved.
//

#import "NoRedInkTerm.h"

@implementation NoRedInkTerm
@synthesize name = _name;
@synthesize gender = _gender;

- (id) initWithName:(NSString *)name gender:(NSUInteger)gender {
    if (gender != NoRedInkTermGenderMale && gender != NoRedInkTermGenderFemale)
        NSAssert(NO, @"gender does not represent a valid value");
    
    
    if ((self = [super init])) {
        self.name = name;
        self.gender = gender;
    }
    
    return self;
}

+ (id) termWithName:(NSString*)name gender:(NSUInteger)gender {
    return [[NoRedInkTerm alloc] initWithName:name gender:gender];
}
@end
