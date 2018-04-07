//
//  ContactsService.h
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactsService : NSObject

- (void)getContacts:(void (^)(NSArray<Contact *> *contacts))completionHandler;
- (void)getInfoFor:(Contact*)contant with:(void (^)(Contact *contact))completionHandler;

@end
