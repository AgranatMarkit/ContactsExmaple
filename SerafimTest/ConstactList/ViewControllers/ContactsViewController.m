//
//  ViewController.m
//  Test
//
//  Created by Марк on 05.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactTableViewCell.h"

@interface ContactsViewController ()

@property NSString *cellID;
@property NSString *titleString;
@property CGFloat rowHeight;

@end

@implementation ContactsViewController

NSString *const  cellID = @"cellID";
NSString *const  titleString = @"Contacts";
CGFloat const rowHeight = 100.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:titleString];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.tableView registerClass:[ContactTableViewCell class] forCellReuseIdentifier: cellID];
}

// MARK: - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell transitToLoadingState];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [cell transitToNormalStateWithImage:[UIImage imageNamed:@"icon1"] andName:@"123131231231231231231212312"];
    });
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

// MARK - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

@end
