//
//  UsersCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/30/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+AFNetworking.h>
#import "UsersModel.h"
#import "UsersViewController.h"

@interface UsersCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *fullNameLabel;
@property (strong, nonatomic) UILabel *locationLabel;

- (void) setCell:(UsersModel *)model;

@end
