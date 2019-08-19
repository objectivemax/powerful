//
//  SourceCollectionCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/13/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "SourceCollectionCell.h"

#define LEFT 16
#define RIGHT 16
#define TOP 10

#define MAIN_HEIGHT 154
#define MAIN_WIDTH 234

#define LABEL_HEIGHT 22

@implementation SourceCollectionCell

- (void) setCell:(NSArray *)model {
    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
    
    // MAIN VIEW
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, MAIN_WIDTH, MAIN_HEIGHT)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 13;
    //shadow
    self.mainView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowOpacity = 0.7f;
    self.mainView.layer.shadowRadius = 4.0;
    [self.contentView addSubview:self.mainView];
    
    
    // NAME SOURCE
    self.sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, MAIN_WIDTH - 8 - 8, LABEL_HEIGHT * 2)];
    self.sourceNameLabel.numberOfLines = 2;
//    self.sourceNameLabel.backgroundColor = [UIColor greenColor];
    self.sourceNameLabel.textAlignment = NSTextAlignmentCenter;
    self.sourceNameLabel.attributedText = [AttributedString headlineASWithColor:[UIColor blackColor] string:[model valueForKey:@"sourceName"]];
    [self.mainView addSubview:self.sourceNameLabel];
    
    
    // WEB LINK
    self.websiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_WIDTH - 4 - 70, MAIN_HEIGHT - LABEL_HEIGHT - 4, 70, LABEL_HEIGHT)];
    self.websiteLabel.layer.cornerRadius = LABEL_HEIGHT/2;
    self.websiteLabel.layer.masksToBounds = YES;
    self.websiteLabel.textAlignment = NSTextAlignmentCenter;
    self.websiteLabel.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.5f];
    self.websiteLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor whiteColor] string:@"website"];
    [self.mainView addSubview:self.websiteLabel];
    
    
    // COUNTRY
    self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, MAIN_HEIGHT - LABEL_HEIGHT - 4, MAIN_WIDTH - 8 - self.websiteLabel.frame.size.width - 4, LABEL_HEIGHT)];
    self.countryLabel.attributedText = [AttributedString subheadASWithColor:[[UIColor blueColor]colorWithAlphaComponent:0.5f] string:[model valueForKey:@"sourceCountry"]];
    [self.mainView addSubview:self.countryLabel];

    
    // DESCRIPTION
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, self.sourceNameLabel.frame.size.height, MAIN_WIDTH - 8 - 8, 0)];

    self.descriptionLabel.attributedText = [AttributedString subheadASWithColor:[UIColor blackColor] string:[model valueForKey:@"sourceDescription"]];

    self.descriptionLabel.numberOfLines = 0;
    [self.descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.descriptionLabel sizeToFit];

    CGRect descFrame = self.descriptionLabel.frame;
    descFrame = CGRectMake(8, self.sourceNameLabel.frame.size.height, MAIN_WIDTH - 8 - 8, MAIN_HEIGHT - self.sourceNameLabel.frame.size.height - self.websiteLabel.frame.size.height - 4 - TOP);
    self.descriptionLabel.frame = descFrame;

    [self.mainView addSubview:self.descriptionLabel];
}

@end
