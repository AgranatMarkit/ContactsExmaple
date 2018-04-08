//
//  Contact.m
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (BOOL)isEmpty {
    return self.name == nil && self.image == nil;
}

- (NSString *)firstTwoChars {
    return self.name.length >= 2 ? [self.name substringToIndex:2] : @"--";
}

-(id)copyWithZone:(NSZone *)zone {
    Contact *copy = [Contact new];
    copy.id = [self.id copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.image = [self.name copyWithZone:zone];
    return copy;
}

@end
