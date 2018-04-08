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
@property NSMutableArray<Contact *> *contacts;

@end

@implementation ContactsViewController

NSString *const cellID = @"cellID";
NSString *const titleString = @"Cattacts";
NSString *const catMessage = @"Meow";
NSString *const patMessage = @"pat";
CGFloat const rowHeight = 100.0;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactsService = [ContactsService new];
    [self setTitle:titleString];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.tableView registerClass:[ContactTableViewCell class] forCellReuseIdentifier: cellID];
    [self setupActivityIndicator];
    [self setupRefresh];
    [self.presenter viewIsReady];
    
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
    [self.presenter viewDidRefresh];
}

- (void)display:(NSArray<Contact *> *)contacts {
    self.contacts = [contacts mutableCopy];
    [self.tableView reloadData];
}

- (void)update:(Contact *)contact {
    // Cell updating
    for (ContactTableViewCell *cell in self.tableView.visibleCells) {
        if (cell.contact.isEmpty && [cell.contact.id isEqualToString:contact.id]) {
            [cell toNormalStateUsing:contact];
        }
    }
    
    // Contacts updating
    NSUInteger indexPath = [self.contacts indexOfObjectPassingTest:^BOOL(Contact * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.id isEqualToString:contact.id];
    }];
    if (indexPath != NSNotFound) {
        self.contacts[indexPath] = contact;
    }
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

- (void) endRefreshing {
    [self.refreshControl endRefreshing];
}

// MARK: - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Contact *contact = self.contacts[indexPath.row];
    
    if (contact.isEmpty) {
        [cell toLoadingStateUsing: contact];
        [self.presenter viewWillShow:contact];
    } else {
        [cell toNormalStateUsing:contact];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

// MARK - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:catMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:patMessage style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:^{}];
}

@end
