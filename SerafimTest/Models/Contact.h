//
//  Contact.h
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contact : NSObject

@property NSString *id;
@property NSString *name;
@property UIImage *image;
@property (readonly) BOOL isEmpty;

@end
