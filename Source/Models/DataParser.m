//
//  DataParser.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "DataParser.h"

@implementation DataParser

- (NSArray *)parseNews:(NSDictionary *)data {
    NSArray * res = nil;
    
    res = [NewsModel getObjectFromArray:[data valueForKey:@"articles"]];
    return res;
}

- (NSArray *)parseFilter:(NSDictionary *)data {
    NSArray *res = nil;
    
    res = [NewsFilterModel getObjectFromArray:[data valueForKey:@"sources"]];
    
    return res;
}

- (NSArray *)parseSource:(NSDictionary *)data {
    NSArray *res = nil;

    res = [SourceModel getObjectFromArray:[data valueForKey:@"sources"]];

    return res;
}

- (NSArray *)parseUsersList:(NSArray *)data {
    NSArray *res = nil;
    
    res = [UsersModel getObjectFromArray:data];
    
    return res;
    
}

@end
