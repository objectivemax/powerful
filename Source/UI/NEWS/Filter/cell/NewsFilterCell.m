//
//  NewsFilterCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "NewsFilterCell.h"

@implementation NewsFilterCell {
    NewsFilterModel *filterModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCell:(NewsFilterModel *)model {
    filterModel = model;
    
    CGSize size = [[UIScreen mainScreen]bounds].size;

    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
    
    // MAIN VIEW
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(4, 8, size.width - 4 - 4, 44)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 20;
    
    //shadow
    self.mainView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowOpacity = 0.7f;
    self.mainView.layer.shadowRadius = 4.0;
    
    [self.contentView addSubview:self.mainView];
    
    
    // SUBSCRIBE
    self.subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width - 80 - 16, 11, 80, 22)];
    
    if (model.isSubscribe) {
        self.subscribeLabel.attributedText =
        [AttributedString badgeASWithColor:[UIColor redColor] string:@"UNSUBSCRIBE"];
        self.subscribeLabel.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.subscribeLabel.attributedText =
        [AttributedString badgeASWithColor:[UIColor whiteColor] string:@"SUBSCRIBE"];
        self.subscribeLabel.backgroundColor = [UIColor blueColor];
    }

    self.subscribeLabel.textAlignment = NSTextAlignmentCenter;
    self.subscribeLabel.layer.cornerRadius = 10;
    self.subscribeLabel.layer.masksToBounds = YES;
    [self.mainView addSubview:self.subscribeLabel];

    
    
    
    
    // SOURCE NAME
    self.sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, size.width - 16 - self.subscribeLabel.frame.size.width - 16, 22)];
    self.sourceNameLabel.attributedText = [AttributedString bodyASWithColor:[UIColor blackColor] string:model.sourceName];
    [self.mainView addSubview:self.sourceNameLabel];


    // CATEGORY
    self.sourceCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, size.width - 16 - self.subscribeLabel.frame.size.width - 16, 22)];
    self.sourceCategoryLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor blackColor] string:model.sourceCategory];
    [self.mainView addSubview:self.sourceCategoryLabel];
    
    

    // SUBSRIBE BUTTON
    self.subscribeButton = [[NewsFilterButton alloc] initWithModel:model];
    self.subscribeButton.nfModel = model;
    [self.subscribeButton setFrame:self.mainView.frame];
    
    if (model.isSubscribe) {
//        self.isSubscribeString = @"SUBSCRIBE";
        self.subscribeButton.tag = 1;
    } else {
//        self.isSubscribeString = @"UNSUBSCRIBE";
        self.subscribeButton.tag = 2;
    }
    
//    [self.subscribeButton setImage:[UIImage imageNamed:self.isSubscribeString] forState:UIControlStateNormal];
    [self.subscribeButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.subscribeButton];

    
    
    
    
    

//    // SEPARATOR
//    self.separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 3)];
//    self.separator.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:self.separator];
    
//    // HEAD SOURCE
//    self.headSource = [[UIView alloc] initWithFrame:CGRectMake(0, 3, size.width, 30)];
//    self.headSource.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.contentView addSubview:self.headSource];
//
//    // SOURCE NAME
//    self.sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 30)];
//    self.sourceNameLabel.text = model.sourceName;
//    self.sourceNameLabel.textAlignment = NSTextAlignmentCenter;
//    [self.sourceNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
//    //        [self.titleLabel setBackgroundColor:[UIColor greenColor]];
//    [self.headSource addSubview:self.sourceNameLabel];
//
//    // DESCRIPTION
//    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 36, size.width-10, 60)];
//    self.descriptionLabel.text = model.sourceDescription;
//    self.descriptionLabel.numberOfLines = 4;
//    [self.descriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
//    //        [self.descriptionLabel setBackgroundColor:[UIColor greenColor]];
//    [self.contentView addSubview:self.descriptionLabel];
//
//    // SUBSRIBE BUTTON
//    self.subscribeButton = [[NewsFilterButton alloc] initWithModel:model];
//    self.subscribeButton.nfModel = model;
//    [self.subscribeButton setFrame:CGRectMake(size.width - 40, 2, 25, 25)];
//
//    if (model.isSubscribe) {
//        self.isSubscribeString = @"done";
//        self.subscribeButton.tag = 1;
//    } else {
//        self.isSubscribeString = @"cancel";
//        self.subscribeButton.tag = 2;
//    }
//
//    [self.subscribeButton setImage:[UIImage imageNamed:self.isSubscribeString] forState:UIControlStateNormal];
//    [self.subscribeButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.headSource addSubview:self.subscribeButton];
    
}

- (IBAction) moreButtonAction:(NewsFilterButton*) sender{
    NSString *isSubscribeIcon;
    NSUInteger index = 0;
    
    self.subscribedArray = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Subscribed"] mutableCopy];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (sender.nfModel.isSubscribe) {
        self.subscribeLabel.attributedText =
        [AttributedString badgeASWithColor:[UIColor whiteColor] string:@"SUBSCRIBE"];
        self.subscribeLabel.backgroundColor = [UIColor blueColor];
        
    
        for (NSString *source in self.subscribedArray) {
            if ([source isEqualToString:filterModel.sourceID]) {
                index = [self.subscribedArray indexOfObject:source];
            }
        }
        
        [self.subscribedArray removeObjectAtIndex:index];

    } else {
        self.subscribeLabel.attributedText =
        [AttributedString badgeASWithColor:[UIColor redColor] string:@"UNSUBSCRIBE"];
        self.subscribeLabel.backgroundColor = [UIColor clearColor];

        [self.subscribedArray addObject:filterModel.sourceID];
    }
    
    
//    if (model.isSubscribe) {
//        self.subscribeLabel.attributedText =
//        [AttributedString badgeASWithColor:[UIColor redColor] string:@"UNSUBSCRIBE"];
//        self.subscribeLabel.layer.borderColor = [UIColor redColor].CGColor;
//    } else {
//        self.subscribeLabel.attributedText =
//        [AttributedString badgeASWithColor:[UIColor whiteColor] string:@"SUBSCRIBE"];
//        self.subscribeLabel.backgroundColor = [UIColor blueColor];
//    }
    
    
    
    // save changes
    [[NSUserDefaults standardUserDefaults] setValue:self.subscribedArray forKey:@"Subscribed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [sender.nfModel subscribeAction];
//    [sender setImage:[UIImage imageNamed:isSubscribeIcon] forState:UIControlStateNormal];
}


@end
