//
//  ContactsPresenter.h
//  SerafimTest
//
//  Created by Марк on 08.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactsView.h"
#import "ContactsService.h"

@interface ContactsPresenter : NSObject

@property (weak) id<ContactsView> view;
- (instancetype)initWith:(ContactsService*)contactsService;
- (void)viewIsReady;
- (void)viewWillShow:(Contact*)contact;
- (void)viewDidRefresh;
- (void)viewDidTapOnSort;

@end
