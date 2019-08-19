//
//  NewsSkeletonCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/30/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "NewsSkeletonCell.h"

@implementation NewsSkeletonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCell {

    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
    CGFloat sizeContent = 200;
    
    
    // MAIN VIEW
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, size.width - 8 - 8, 200)];
    self.mainView.layer.cornerRadius = 20;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.skeletonStyle = SkeletonStyleShine;
    [self.contentView addSubview:self.mainView];
    
    // full size content neight
    sizeContent = 8 + 200;
    
    
    // HEADER VIEW
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(40, 8, self.mainView.frame.size.width - 40 - 40, 32)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    // corner radius view only: left bottom | right bottom
    UIBezierPath *headerMaskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerView.bounds byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *headerMaskLayer = [[CAShapeLayer alloc] init];
    headerMaskLayer.frame = self.headerView.bounds;
    headerMaskLayer.path = headerMaskPath.CGPath;
    self.headerView.layer.mask = headerMaskLayer;
    [self.contentView addSubview:self.headerView];
    
    
    // HEADER TEXT
    self.sourceNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(LEFT, 0, self.headerView.frame.size.width - LEFT - RIGHT, TITLE_HEIGHT)];
    self.sourceNameLabel.layer.cornerRadius = 11;
    self.sourceNameLabel.layer.masksToBounds = YES;
    self.sourceNameLabel.skeletonStyle = SkeletonStyleShine;
    [self.headerView addSubview:self.sourceNameLabel];
    
    
    // TITLE NEWS
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, sizeContent + 8, size.width - LEFT - RIGHT, TITLE_HEIGHT)];
    self.titleLabel.layer.cornerRadius = 8;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.skeletonStyle = SkeletonStyleShine;
    [self.contentView addSubview:self.titleLabel];
    
    // full size content neight
    sizeContent = sizeContent + 8 + self.titleLabel.frame.size.height;
    
    
    // DESCRIPTION
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, sizeContent + 4, size.width - LEFT - RIGHT, TITLE_HEIGHT)];
    self.descriptionLabel.layer.cornerRadius = 8;
    self.descriptionLabel.layer.masksToBounds = YES;
    self.descriptionLabel.skeletonStyle = SkeletonStyleShine;
    [self.contentView addSubview:self.descriptionLabel];
    
    // full size content neight
    sizeContent = sizeContent + 4 + self.descriptionLabel.frame.size.height;
    

    // DATE
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, sizeContent + 10, 100, 18)];
    self.dateLabel.layer.cornerRadius = 6;
    self.dateLabel.layer.masksToBounds = YES;
    self.dateLabel.skeletonStyle = SkeletonStyleShine;
    [self.contentView addSubview:self.dateLabel];

    // full size content neight
    sizeContent = sizeContent + 10 + self.dateLabel.frame.size.height;
    
    
    
    
    
    
    
    
    self.headerView.skeletonStatus = SkeletonStatusBegin;
    self.contentView.skeletonStatus = SkeletonStatusBegin;
}

@end
