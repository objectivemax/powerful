//
//  NewsSkeletonCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/30/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkeletonAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsSkeletonCell : UITableViewCell

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *sourceNameLabel;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *dateLabel;



- (void) setCell;

@end

NS_ASSUME_NONNULL_END
