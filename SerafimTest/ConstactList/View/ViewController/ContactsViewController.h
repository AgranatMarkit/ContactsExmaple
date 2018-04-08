//
//  ViewController.h
//  Test
//
//  Created by Марк on 05.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsView.h"
#import "ContactsPresenter.h"

@class ContactsPresenter;


@interface ContactsViewController : UITableViewController<ContactsView>

@property ContactsPresenter* presenter;

@end

