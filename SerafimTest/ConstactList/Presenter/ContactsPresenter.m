//
//  ContactsPresenter.m
//  SerafimTest
//
//  Created by Марк on 08.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ContactsPresenter.h"

@interface ContactsPresenter()

@property ContactsService *contactsService;

@end


@implementation ContactsPresenter

- (instancetype)initWith:(ContactsService*)contactsService
{
    self = [super init];
    if (self) {
        self.contactsService = contactsService;
    }
    return self;
}

- (void)viewIsReady {
    [self.view showActivity];
    __weak ContactsPresenter *weakSelf = self;
    [self.contactsService getContacts:^(NSArray<Contact *> *contacts) {
        ContactsPresenter *strongSelf = weakSelf;
        [strongSelf.view hideActvity];
        [strongSelf.view display:contacts];
    }];
}

- (void)viewWillShow:(Contact*)contact {
    __weak ContactsPresenter *weakSelf = self;
    [self.contactsService getInfoFor:contact with:^(Contact *contact) {
        ContactsPresenter *strongSelf = weakSelf;
        [contact setName:[strongSelf validatedNameFrom:contact.name]];
        [strongSelf.view update:contact];
    }];
}

- (NSString*)validatedNameFrom:(NSString*)name {
    NSMutableString *validatedString = [@"noname" mutableCopy];
    if ([name rangeOfString:@"^[a-z0-9]+$" options:NSRegularExpressionSearch].location != NSNotFound) {
        [validatedString setString:name];
    }
    return validatedString;
}

- (void)viewDidRefresh {
    __weak ContactsPresenter *weakSelf = self;
    [self.contactsService getContacts:^(NSArray<Contact *> *contacts) {
        ContactsPresenter *strongSelf = weakSelf;
        [strongSelf.view endRefreshing];
        [strongSelf.view display:contacts];
    }];
}

@end
