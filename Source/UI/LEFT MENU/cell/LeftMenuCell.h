//
//  LeftMenuCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *separatorView;

-(void)setCell:(NSString *)text;

@end
