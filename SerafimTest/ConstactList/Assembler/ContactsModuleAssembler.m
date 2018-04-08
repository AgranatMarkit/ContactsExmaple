//
//  ContactsAssembler.m
//  SerafimTest
//
//  Created by Марк on 08.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ContactsModuleAssembler.h"
#import "ContactsPresenter.h"
#import "ContactsService.h"

@implementation ContactsModuleAssembler

+ (ContactsViewController *)assemble {
    ContactsService *service = [ContactsService new];
    ContactsPresenter *presenter = [[ContactsPresenter alloc] initWith:service];
    ContactsViewController *viewController = [ContactsViewController new];
    viewController.presenter = presenter;
    presenter.view = viewController;
    return viewController;
}

@end
