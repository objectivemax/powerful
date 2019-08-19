//
//  NewsFilterButton.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "NewsFilterButton.h"

@implementation NewsFilterButton

- (instancetype)initWithModel:(NewsFilterModel*)model {
    self = (NewsFilterButton *)[NewsFilterButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.nfModel = model;
    }
    return self;
}

@end
