//
//  NewsFilterCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFilterModel.h"
#import "NewsFilterViewController.h"
#import "NewsFilterButton.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface NewsFilterCell : UITableViewCell

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *sourceNameLabel;
@property (strong, nonatomic) UILabel *sourceCategoryLabel;
@property (strong, nonatomic) UILabel *subscribeLabel;
@property (strong, nonatomic) NewsFilterButton *subscribeButton;
//@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) NSString *isSubscribeString;
//@property FIRDatabaseReference *ref;
//@property (assign, nonatomic) BOOL isWrite;
//@property (strong, nonatomic) UIView *separator;

@property (strong, nonatomic) NSMutableArray *subscribedArray;

- (void) setCell:(NewsFilterModel *)model;

@end

NS_ASSUME_NONNULL_END

