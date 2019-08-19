//
//  NewsCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "NewsCell.h"

#define LEFT 16
#define RIGHT 16
#define TOP 10

#define LABEL_HEIGHT 22


@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) setCell:(NewsModel *)model {
//    newsModel = model;
    
    CGSize size = [[UIScreen mainScreen]bounds].size;
    self.fullSizeContentView = [[UIView alloc] init];
    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
//    // SEPARATOR
//    self.separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 3)];
//    self.separator.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:self.separator];
    
//    // HEAD SOURCE NAME
//    self.headSourceName = [[UIView alloc] initWithFrame:CGRectMake(0, 3, width, 20)];
//    self.headSourceName.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.contentView addSubview:self.headSourceName];
//
//    // SOURCE NAME
//    self.sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
//    self.sourceNameLabel.textAlignment = NSTextAlignmentCenter;
//    [self.sourceNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
//    //    [self.titleLabel setBackgroundColor:[UIColor greenColor]];
//    if (model.sourceName) {
//        self.sourceNameLabel.text = model.sourceName;
//    } else {
//        self.sourceNameLabel.text = model.sourceName;
//    }
//    [self.headSourceName addSubview:self.sourceNameLabel];
//
//
//    // IMAGE
//    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 28, 117, 117)];
//    self.image.contentMode = UIViewContentModeScaleAspectFill;
//    self.image.clipsToBounds = YES;
//    if (model.urlPic) {
//        [self.image setImageWithURL:model.urlPic];
//    }
//    [self.contentView addSubview:self.image];
//
//    // TITLE
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.bounds.size.width+20, 26, width-145, 40)];
//    self.titleLabel.numberOfLines = 2;
//    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
////    [self.titleLabel setBackgroundColor:[UIColor greenColor]];
//    if (model.title){
//        self.titleLabel.text = model.title;
//    } else {
//        self.titleLabel.text = @"";
//    }
//    [self.contentView addSubview:self.titleLabel];
//
//    // DESCRIPTION
//    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.bounds.size.width+20, 70, width-145, 63)];
//    self.descriptionLabel.numberOfLines = 4;
//    [self.descriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
////    [self.descriptionLabel setBackgroundColor:[UIColor redColor]];
//    if (model.description){
//        self.descriptionLabel.text = model.descript;
//    } else {
//        self.descriptionLabel.text = @"";
//    }
//    [self.contentView addSubview:self.descriptionLabel];
//
//    // AUTHOR
//    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.bounds.size.width+10, 137, 100, 10)];
//    self.authorLabel.textColor = [UIColor grayColor];
//    [self.authorLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
////    [self.authorLabel setBackgroundColor:[UIColor greenColor]];
//    if ([model.author isEqual:@""]) {
//        self.authorLabel.text = model.author;
//    } else {
//        self.authorLabel.text = @"";
//    }
//    [self.contentView addSubview:self.authorLabel];
//
    // DATE
//    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(width-80, 137, 80, 10)];
//    self.dateLabel.textAlignment = 1;
//    [self.dateLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
////    [self.dateLabel setBackgroundColor:[UIColor greenColor]];
//
//    self.dateLabel.textColor = [UIColor grayColor];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd.MM.yy HH:mm"];
//    if (model.date){
//        self.dateLabel.text = [formatter stringFromDate:model.date];
//    } else {
//        self.dateLabel.text = @"";
//    }
//    [self.contentView addSubview:self.dateLabel];
    
    
    // MAIN VIEW
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, size.width - 8 - 8, 0)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 20;
    
    //shadow
    self.mainView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowOpacity = 0.7f;
    self.mainView.layer.shadowRadius = 4.0;
    
    [self.contentView addSubview:self.mainView];
    
    
    // IMAGE
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,  self.mainView.frame.size.width, 300)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageWithData:model.dataPic];
    self.headerImageView.image = image;
//    self.headerImageView.backgroundColor = [UIColor blueColor];
    
    // corner radius view only: left bottom | right bottom
    UIBezierPath *imageMaskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerImageView.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *imageMaskLayer = [[CAShapeLayer alloc] init];
    imageMaskLayer.frame = self.headerImageView.bounds;
    imageMaskLayer.path = imageMaskPath.CGPath;
    self.headerImageView.layer.mask = imageMaskLayer;

    
    // resize image view
    float ratio = image.size.width / image.size.height;
    
    if (self.headerImageView.frame.size.width > self.headerImageView.frame.size.height) {
        float newHeight = self.headerImageView.frame.size.width / ratio;
        self.headerImageView.frame = CGRectMake(self.headerImageView.frame.origin.x,
                                                self.headerImageView.frame.origin.y,
                                                self.headerImageView.frame.size.width,
                                                newHeight);
    } else {
        float newWidth = self.headerImageView.frame.size.height * ratio;
        self.headerImageView.frame = CGRectMake(self.headerImageView.frame.origin.x,
                                                self.headerImageView.frame.origin.y,
                                                newWidth,
                                                self.headerImageView.frame.size.height);
    }

    [self.mainView addSubview:self.headerImageView];
    
    
    // HEADER VIEW
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, self.mainView.frame.size.width - 40 - 40, 32)];
    self.headerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    // corner radius view only: left bottom | right bottom
    UIBezierPath *headerMaskPath = [UIBezierPath bezierPathWithRoundedRect:self.headerView.bounds byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *headerMaskLayer = [[CAShapeLayer alloc] init];
    headerMaskLayer.frame = self.headerView.bounds;
    headerMaskLayer.path = headerMaskPath.CGPath;
    self.headerView.layer.mask = headerMaskLayer;
    [self.mainView addSubview:self.headerView];
    
    
    // HEADER TEXT
    self.sourceNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(LEFT, 5, self.headerView.frame.size.width - LEFT - RIGHT, LABEL_HEIGHT)];
    self.sourceNameLabel.textAlignment = NSTextAlignmentCenter;
    self.sourceNameLabel.attributedText = [AttributedString headlineASWithColor:[UIColor blackColor] string:model.sourceName];
    [self.headerView addSubview:self.sourceNameLabel];
    
    // TITLE NEWS
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, self.headerImageView.frame.size.height + 8, self.mainView.frame.size.width - LEFT - RIGHT, 0)];
//    self.titleLabel.backgroundColor = [UIColor whiteColor];
//    self.titleLabel.text = model.title;
    self.titleLabel.attributedText = [AttributedString bodyASWithColor:[UIColor blackColor] string:model.title];
    
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleLabel sizeToFit];
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame = CGRectMake(titleFrame.origin.x, titleFrame.origin.y, self.mainView.frame.size.width - LEFT - RIGHT, titleFrame.size.height);
    self.titleLabel.frame = titleFrame;

    [self.mainView addSubview:self.titleLabel];
    
    
    // DESCRIPTION
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, self.headerImageView.frame.size.height + 8 + self.titleLabel.frame.size.height + 4, self.mainView.frame.size.width - LEFT - RIGHT, 0)];
    
//    self.descriptionLabel.backgroundColor = [UIColor whiteColor];
    self.descriptionLabel.attributedText = [AttributedString subheadASWithColor:[UIColor blackColor] string:model.descript];
    
    self.descriptionLabel.numberOfLines = 0;
    [self.descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.descriptionLabel sizeToFit];
    
    CGRect descFrame = self.descriptionLabel.frame;
    descFrame = CGRectMake(descFrame.origin.x, descFrame.origin.y, self.mainView.frame.size.width - LEFT - RIGHT, descFrame.size.height);
    self.descriptionLabel.frame = descFrame;
    
    [self.mainView addSubview:self.descriptionLabel];
    
    
    
    // DATE
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, self.headerImageView.frame.size.height + 8 + self.titleLabel.frame.size.height + 4 + self.descriptionLabel.frame.size.height + 10, self.mainView.frame.size.width/2 - LEFT, LABEL_HEIGHT)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yy   HH:mm"];
    if (model.date){
        self.dateLabel.attributedText = [AttributedString footnoteASWithColor:[[UIColor blueColor]colorWithAlphaComponent:0.5f] string:[formatter stringFromDate:model.date]];
    } else {
        self.dateLabel.attributedText = [AttributedString footnoteASWithColor:[[UIColor blueColor]colorWithAlphaComponent:0.5f] string:@""];
    }
    [self.mainView addSubview:self.dateLabel];
    
    
    
    
    //resize main view
    self.mainView.frame = CGRectMake(self.mainView.frame.origin.x,
                                     self.mainView.frame.origin.y,
                                     self.mainView.frame.size.width,
                                     self.headerImageView.frame.size.height + 8 + self.titleLabel.frame.size.height + 4 + self.descriptionLabel.frame.size.height + 10 + self.dateLabel.frame.size.height + 10);

    
    
    
    
    
    
    // full height cell
    [self.fullSizeContentView setFrame:CGRectMake(0, 0, size.width, 8 + self.mainView.frame.size.height + 8)];
    
}




@end
