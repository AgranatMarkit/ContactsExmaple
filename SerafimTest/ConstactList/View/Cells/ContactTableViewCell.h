//
//  ContactTableViewCell.h
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactTableViewCell : UITableViewCell

@property Contact *contact;
- (void)toLoadingStateUsing: (Contact *)contact;
- (void)toNormalStateUsing: (Contact *)contact;

@end
