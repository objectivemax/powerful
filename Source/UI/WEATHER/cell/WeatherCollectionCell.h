//
//  WeatherCollectionCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/8/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *valueLabel;

- (void) setCell:(NSArray *)model;

@end

NS_ASSUME_NONNULL_END
