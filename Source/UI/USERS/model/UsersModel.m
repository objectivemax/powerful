//
//  UsersModel.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/30/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "UsersModel.h"

#define   SHOW_LOGS             NO
#define   Error(format, ...)    if (SHOW_LOGS) NSLog(@"ERROR: %@", [NSString stringWithFormat:format, ## __VA_ARGS__]);

@implementation UsersModel

+ (NSArray *) getObjectFromArray:(NSArray *)data {
    if ((id)data == [NSNull null]) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        @try {
            [result insertObject:[UsersModel usersFromDictionary:dict] atIndex:0];
        }
        @catch (NSException *exception) {
            Error(@"%@", exception);
        }
    }
    return result;
}

+(UsersModel *)usersFromDictionary:(NSDictionary *)data {
    UsersModel *model = [[UsersModel alloc] init];
    
    model.uid = data[@"uid"];
    model.email = data[@"email"];
    model.password = data[@"password"];
    model.birthday = data[@"birthday"];
    model.city = data[@"city"];
    model.country = data[@"country"];
    model.firstName = data[@"firstName"];
    model.lastName = data[@"lastName"];
    model.phone = data[@"phone"];
    model.image = data[@"image"];

    return model;
}

@end
