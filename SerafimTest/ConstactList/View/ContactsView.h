//
//  ContactsView.h
//  SerafimTest
//
//  Created by Марк on 08.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@protocol ContactsView

- (void)showContacts:(NSArray<Contact*>*) contacts;
- (void)update:(Contact*)contact;
- (void)updateContacts:(NSArray<Contact *>*)Contacts;
- (void)showActivity;
- (void)hideActvity;
- (void)endRefreshing;

@end
