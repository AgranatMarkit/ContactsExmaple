//
//  ContactsService.m
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ContactsService.h"

@implementation ContactsService

- (void)getContacts:(void (^)(NSArray<Contact *> *contacts))completionHandler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray<Contact *> *contacts = [NSMutableArray new];
        for (int i = 0; i < 1000; i++)
        {
            Contact *contact = [Contact new];
            [contact setId:[NSString stringWithFormat:@"%d", i]];
            [contacts addObject: contact];
        }
        completionHandler(contacts);
    });
}

- (void)getInfoFor:(Contact*)contact with:(void (^)(Contact *contact))completionHandler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self randomTime])), dispatch_get_main_queue(), ^{
        Contact *newContact = [contact copy];
        [newContact setName:[self randomName]];
        [newContact setImage:[self randomImage]];
        completionHandler(newContact);
    });
}

- (int64_t)randomTime {
    return [self getRandomNumberBetweenLowerBound:10 andUpperBound:30] * (NSEC_PER_SEC / 10);
}

- (NSString*)randomName {
    NSArray *names = @[@"Nickname", @"Caty", @"Кот", @"cat", @"кот"];
    return names[[self getRandomNumberBetweenLowerBound:0 andUpperBound:(int)names.count]];
}

- (UIImage*)randomImage {
    NSString *imageName = [[NSString alloc] initWithFormat:@"icon%d",
                           [self getRandomNumberBetweenLowerBound:1 andUpperBound:7]];
    return [UIImage imageNamed:imageName];
}

- (int)getRandomNumberBetweenLowerBound:(int)lowerBound andUpperBound:(int)upperBound {
    return lowerBound + arc4random() % (upperBound - lowerBound);
}

@end
