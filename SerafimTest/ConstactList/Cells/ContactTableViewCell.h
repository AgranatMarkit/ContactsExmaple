//
//  ContactTableViewCell.h
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell

- (void) transitToLoadingState;
- (void) transitToNormalStateWithImage:(UIImage*)image andName:(NSString*)name;

@end
