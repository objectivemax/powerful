//
//  NewsFilterButton.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsFilterButton : UIButton

@property (strong, nonatomic) NewsFilterModel* nfModel;
@property (assign, nonatomic) BOOL isSubscribe;


- (instancetype)initWithModel:(NewsFilterModel*)model;

@end

NS_ASSUME_NONNULL_END
