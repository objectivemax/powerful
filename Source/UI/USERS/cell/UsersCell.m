//
//  UsersCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/30/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "UsersCell.h"

@implementation UsersCell{
    UsersModel *usersModel;
}

- (void) setCell:(UsersModel *)model {
    usersModel = model;
    
    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
    // USERS IMAGE
    NSString *userAvatar = [NSString stringWithFormat:@"%@",[model valueForKey:@"image"]];
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP, CELL_HEIGHT_BIG - TOP - TOP, CELL_HEIGHT_BIG - TOP - TOP)];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
    self.avatarImageView.layer.masksToBounds = YES;
    
    if ([userAvatar isEqualToString:@""]) {
        self.avatarImageView.image = [UIImage imageNamed:@"user"];
    } else {
        [self.avatarImageView setImageWithURL:[model valueForKey:@"image"]];
    }
    [self.contentView addSubview:self.avatarImageView];
    
    
    // USER FULL NAME
    self.fullNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT + self.avatarImageView.frame.size.width + LEFT, TOP, size.width - LEFT - self.avatarImageView.frame.size.width - LEFT - RIGHT, TITLE_HEIGHT)];
    self.fullNameLabel.attributedText = [AttributedString bodyASWithColor:[UIColor blackColor] string:[NSString stringWithFormat:@"%@ %@",[model valueForKey:@"firstName"], [model valueForKey:@"lastName"]]];
    [self.contentView addSubview:self.fullNameLabel];
    
    
    // USER LOCATION
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT + self.avatarImageView.frame.size.width + LEFT, TOP + TITLE_HEIGHT, size.width - LEFT - self.avatarImageView.frame.size.width - LEFT - RIGHT, TITLE_HEIGHT)];
    self.locationLabel.attributedText = [AttributedString subheadASWithColor:[UIColor blackColor] string:[NSString stringWithFormat:@"(%@ / %@)",[model valueForKey:@"country"], [model valueForKey:@"city"]]];
    [self.contentView addSubview:self.locationLabel];
}

@end
