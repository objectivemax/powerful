//
//  NewsCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import <UIImageView+AFNetworking.h>
#import "NewsViewController.h"

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) UIView *fullSizeContentView;

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *sourceNameLabel;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *dateLabel;

- (void) setCell:(NewsModel *)model;

@end
