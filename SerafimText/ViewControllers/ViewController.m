//
//  ViewController.m
//  Test
//
//  Created by Марк on 05.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UITableView *tableView;
@property NSString *cellID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellID = @"cellID";
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.frame;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: self.cellID];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID];
    
    NSString *string = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row + 1];
    [[cell textLabel] setText: string];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}
@end
