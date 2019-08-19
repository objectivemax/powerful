//
//  SourceCollectionCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/13/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributedString.h"

NS_ASSUME_NONNULL_BEGIN

@interface SourceCollectionCell : UICollectionViewCell

- (void) setCell:(NSArray *)model;

@property (strong, nonatomic) UIView *mainView;
//@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *sourceNameLabel;
//@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UILabel *websiteLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *countryLabel;

@end

NS_ASSUME_NONNULL_END
