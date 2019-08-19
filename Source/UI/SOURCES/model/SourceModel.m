//
//  SourceModel.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/29/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "SourceModel.h"

#define   SHOW_LOGS             NO
#define   Error(format, ...)    if (SHOW_LOGS) NSLog(@"ERROR: %@", [NSString stringWithFormat:format, ## __VA_ARGS__]);

@implementation SourceModel

+ (NSArray *) getObjectFromArray:(NSArray *)data {
    if ((id)data == [NSNull null]) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        @try {
            [result insertObject:[SourceModel sourceFromDictionary:dict] atIndex:0];
        }
        @catch (NSException *exception) {
            Error(@"%@", exception);
        }
    }
    return result;
}

+(SourceModel *)sourceFromDictionary:(NSDictionary *)data {
    SourceModel *model = [[SourceModel alloc] init];
    
    model.sourceID = data[@"id"];
    model.sourceName = data[@"name"];
    model.sourceDescription = data[@"description"];
    model.sourceURL = [NSURL URLWithString:data[@"url"]];
    model.sourceCategory = data[@"category"];
    model.sourceLang = data[@"language"];
    
    // COUNTRY
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
    
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    for (NSString *countryCode in countryArray) {
        if ([countryCode isEqualToString:[data[@"country"] uppercaseString]]) {
           model.sourceCountry = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        }
    }
    return model;
}

@end
