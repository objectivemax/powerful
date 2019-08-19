//
//  LeftMenuCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

- (void)setCell:(NSString *)text {
    
    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
    
    
    // ICON
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP, ICON_SIZE, ICON_SIZE)];

    if ([text isEqualToString:@"News"]) {
        self.iconImageView.image = [UIImage imageNamed:@"newspaper.png"];
    }
    
    if ([text isEqualToString:@"Sources"]) {
        self.iconImageView.image = [UIImage imageNamed:@"source.png"];
    }
    
    if ([text isEqualToString:@"Weather"]) {
        self.iconImageView.image = [UIImage imageNamed:@"weather.png"];
    }
    
    if ([text isEqualToString:@"Users"]) {
        self.iconImageView.image = [UIImage imageNamed:@"user.png"];
    }
    
    if ([text isEqualToString:@"Profile"]) {
        self.iconImageView.image = [UIImage imageNamed:@"profile.png"];
    }
    
    if ([text isEqualToString:@"Logout"]) {
        self.iconImageView.image = [UIImage imageNamed:@"logout.png"];
    }
    
    [self.contentView addSubview:self.iconImageView];
    
        
    
    // TITLE
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT + ICON_SIZE + LEFT, TOP, 200, TITLE_HEIGHT)];
    self.titleLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor blackColor] string:text];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.separatorView = [[UIView alloc] initWithFrame:CGRectMake(LEFT, CELL_HEIGHT_STANDART - SEPARATOR_HEIGHT, size.width - LEFT, SEPARATOR_HEIGHT)];
    self.separatorView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.separatorView];

}

@end

