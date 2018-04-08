//
//  ContactTableViewCell.m
//  SerafimTest
//
//  Created by Марк on 07.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "ContactTableViewCell.h"

@interface ContactTableViewCell()

@property UIActivityIndicatorView *activityIndicator;
@property UIImageView *contactImageView;
@property UILabel *shortcutLabel;
@property UILabel *contactNameLabel;

@end


@implementation ContactTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    [self setupLayout];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

-(void)setupUI {
    // image
    self.contactImageView = [UIImageView new];
    self.contactImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.contactImageView.clipsToBounds = true;
    [self.contentView addSubview:self.contactImageView];
    
    // shortcut label
    self.shortcutLabel = [UILabel new];
    self.shortcutLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightHeavy];
    self.shortcutLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.shortcutLabel];
    
    // name label
    self.contactNameLabel = [[UILabel alloc] init];
    self.contactNameLabel.numberOfLines = 0;
    [self.contentView addSubview: self.contactNameLabel];
    
    // activity
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.hidesWhenStopped = true;
    [self.contentView addSubview: self.activityIndicator];
}

- (void)setupLayout {
    UIView *container = self.contentView;
    
    // image
    UIEdgeInsets imgInsets = UIEdgeInsetsMake(8, 8, 8, 0);
    CGRect imgFrame = CGRectOffset(container.frame,
                                   imgInsets.left ,
                                   imgInsets.top);
    CGFloat imgHeight = container.frame.size.height - imgInsets.top - imgInsets.bottom;
    imgFrame.size = CGSizeMake(imgHeight, imgHeight);
    self.contactImageView.frame = imgFrame;
    
    // shortcut label
    self.shortcutLabel.frame = self.contactImageView.frame;
    
    // name label
    UIEdgeInsets lblInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    CGRect lblFrame = CGRectOffset(container.frame,
                                  CGRectGetMaxX(imgFrame) + lblInsets
                                  .left,
                                  lblInsets.top);
    CGFloat lblHeight = container.frame.size.height - lblInsets.top - lblInsets.bottom;
    CGFloat lblWidth = container.frame.size.width - CGRectGetMaxX(imgFrame) - lblInsets.left - lblInsets.right;
    lblFrame.size = CGSizeMake(lblWidth, lblHeight);
    self.contactNameLabel.frame = lblFrame;
    
    // activity
    self.activityIndicator.center = container.center;
}

// MARK: - Cell API

- (void)toLoadingStateUsing: (Contact *)contact {
    self.contact = contact;
    [self.contactImageView setHidden: true];
    [self.shortcutLabel setHidden:true];
    [self.contactNameLabel setHidden: true];
    [self.activityIndicator startAnimating];
}

- (void)toNormalStateUsing: (Contact *)contact {
    self.contact = contact;
    [self.contactImageView setHidden: false || contact.image == nil];
    [self.shortcutLabel setHidden: contact.image != nil];
    [self.contactNameLabel setHidden: false];
    [self.shortcutLabel setText: contact.firstTwoChars.uppercaseString];
    [self.contactImageView setImage: contact.image];
    [self.contactNameLabel setText: contact.name];
    [self.activityIndicator stopAnimating];
}

@end
