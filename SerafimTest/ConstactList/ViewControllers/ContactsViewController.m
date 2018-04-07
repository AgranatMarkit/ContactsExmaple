//
//  ViewController.m
//  Test
//
//  Created by Марк on 05.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactTableViewCell.h"
#import "ContactsService.h"

@interface ContactsViewController ()

@property UIActivityIndicatorView *activityIndicator;
@property NSString *cellID;
@property NSString *titleString;
@property CGFloat rowHeight;
@property ContactsService *contactsService;
@property NSArray<Contact *> *contacts;

@end

@implementation ContactsViewController

NSString *const  cellID = @"cellID";
NSString *const  titleString = @"Contacts";
CGFloat const rowHeight = 100.0;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactsService = [ContactsService new];
    [self setTitle:titleString];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.tableView registerClass:[ContactTableViewCell class] forCellReuseIdentifier: cellID];
    [self setupActivityIndicator];
    [self setupRefresh];
    [self updateDataSource];
    
}

- (void) setupRefresh {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void) setupActivityIndicator {
    self.activityIndicator = [UIActivityIndicatorView new];
    self.activityIndicator.hidesWhenStopped = true;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.tableView.backgroundView = self.activityIndicator;
}

- (void)refresh {
    __weak ContactsViewController *weakSelf = self;
    [self getContacts:^{
        ContactsViewController *strongSelf = weakSelf;
        [strongSelf.refreshControl endRefreshing];
    }];
}

- (void) updateDataSource {
    [self showActivity];
    __weak ContactsViewController *weakSelf = self;
    [self getContacts:^{
        ContactsViewController *strongSelf = weakSelf;
        [strongSelf hideActvity];
    }];
}

- (void) getContacts:(void (^)(void))completionHandler {
    __weak ContactsViewController *weakSelf = self;
    [self.contactsService getContacts:^(NSArray<Contact *> *contacts) {
        ContactsViewController *strongSelf = weakSelf;
        strongSelf.contacts = contacts;
        [strongSelf.tableView reloadData];
        completionHandler();
    }];
}

- (void) showActivity {
    [self.view setUserInteractionEnabled: false];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.activityIndicator startAnimating];
}

- (void) hideActvity {
    [self.view setUserInteractionEnabled: true];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.activityIndicator stopAnimating];
}

// MARK: - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Contact *contact = self.contacts[indexPath.row];
    
    if (contact.isEmpty) {
        [cell transitToLoadingState];
        __weak ContactsViewController *weakSelf = self;
        [self.contactsService getInfoFor:self.contacts[indexPath.row] with:^(Contact *contact) {
            ContactsViewController *strongSelf = weakSelf;
            [strongSelf updateVisibleCellsIn:tableView using:contact];
        }];
    } else {
        [cell transitToNormalStateWithContact:contact];
    }
    return cell;
}

- (void)updateVisibleCellsIn:(UITableView*)tableView using:(Contact*)contact  {
    NSArray *visibleCells = tableView.visibleCells;
    for (ContactTableViewCell *contactCell in visibleCells) {
        NSInteger row = [[tableView indexPathForCell:contactCell] row];
        NSInteger indexOfContact = [self.contacts indexOfObjectPassingTest:^BOOL(Contact * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj.id isEqualToString: contact.id];
        }];
        if (row == indexOfContact) {
            [contactCell transitToNormalStateWithContact:contact];
        }
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

// MARK - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

@end
