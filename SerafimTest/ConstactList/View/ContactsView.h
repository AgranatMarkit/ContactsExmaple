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

- (void)display:(NSArray<Contact*>*) contacts;
- (void)update:(Contact*)contact;
- (void)showActivity;
- (void)hideActvity;
- (void)endRefreshing;

@end
