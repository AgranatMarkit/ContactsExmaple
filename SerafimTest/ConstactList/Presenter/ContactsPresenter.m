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

@property NSMutableArray<Contact *> *contacts;

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
        [strongSelf.view showContacts:contacts];
        strongSelf.contacts = [contacts mutableCopy];
    }];
}

- (void)viewWillShow:(Contact*)contact {
    __weak ContactsPresenter *weakSelf = self;
    [self.contactsService getInfoFor:contact with:^(Contact *contact) {
        ContactsPresenter *strongSelf = weakSelf;
        [contact setName:[strongSelf validatedNameFrom:contact.name]];
        [strongSelf updateContactsWith:contact];
        [strongSelf.view update:contact];
    }];
}

- (void)updateContactsWith:(Contact*)contact {
    // Contacts updating
    NSUInteger indexPath = [self.contacts indexOfObjectPassingTest:^BOOL(Contact * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.id isEqualToString:contact.id];
    }];
    if (indexPath != NSNotFound) {
        self.contacts[indexPath] = contact;
    }
    [self.view updateContacts:self.contacts];
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
        [strongSelf.view showContacts:contacts];
    }];
}

- (void)viewDidTapOnSort {
   NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                ascending:NO
                                                                       selector:@selector(localizedStandardCompare:)];
    [self.contacts sortUsingDescriptors:@[nameSortDescriptor]];
    [self.view showContacts:self.contacts];
}

@end
