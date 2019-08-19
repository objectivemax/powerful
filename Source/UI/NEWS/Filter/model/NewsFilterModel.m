//
//  NewsFilterModel.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "NewsFilterModel.h"

#define   SHOW_LOGS             NO
#define   Error(format, ...)    if (SHOW_LOGS) NSLog(@"ERROR: %@", [NSString stringWithFormat:format, ## __VA_ARGS__]);

@implementation NewsFilterModel

+ (NSArray *) getObjectFromArray:(NSArray *)data {
    if ((id)data == [NSNull null]) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        @try {
            [result insertObject:[NewsFilterModel sourceFromDictionary:dict] atIndex:0];
        }
        @catch (NSException *exception) {
            Error(@"%@", exception);
        }
    }
    return result;
}

+(NewsFilterModel *)sourceFromDictionary:(NSDictionary *)data {
    NewsFilterModel *model = [[NewsFilterModel alloc] init];
    
    model.sourceID = data[@"id"];
    model.sourceName = data[@"name"];
    model.sourceDescription = data[@"description"];
    model.sourceURL = [NSURL URLWithString:data[@"url"]];
    model.sourceCategory = data[@"category"];
    model.sourceLang = data[@"language"];
    model.sourceCountry = data[@"country"];
    model.isSubscribe = false;
    
    NSArray *subscribedArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Subscribed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    for (NSString *source in subscribedArray) {
        NSString *stringWithoutSpaces = [source
                                         stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        if ([model.sourceID isEqualToString:stringWithoutSpaces]) {
            model.isSubscribe = true;
        }
    }

    return model;
}

- (void) subscribeAction {
    if(self.isSubscribe){
        self.isSubscribe = FALSE;
    }
    else
    {
        self.isSubscribe = TRUE;
    }
}

@end

