//
//  NewsModel.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "NewsModel.h"

#define   SHOW_LOGS             NO
#define   Error(format, ...)    if (SHOW_LOGS) NSLog(@"ERROR: %@", [NSString stringWithFormat:format, ## __VA_ARGS__]);

@implementation NewsModel

+ (NSArray *) getObjectFromArray:(NSArray *)data {
    if ((id)data == [NSNull null]) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        @try {
            [result insertObject:[NewsModel newsFromDictionary:dict] atIndex:0];
        }
        @catch (NSException *exception) {
            Error(@"%@", exception);
        }
    }
    return result;
}

+(NewsModel *)newsFromDictionary:(NSDictionary *)data {
    NewsModel *model = [[NewsModel alloc] init];
    
    NSDictionary *source = [data objectForKey:@"source"];
    
    model.sourceID = source[@"id"];
    model.sourceName = source[@"name"];
    model.author = data[@"author"];
    model.title = data[@"title"];
    model.descript = data[@"description"];
    model.urlInfo = [NSURL URLWithString:data[@"url"]];
    model.dataPic = [NSData dataWithContentsOfURL:[NSURL URLWithString:data[@"urlToImage"]]];
    
    NSString *time = data[@"publishedAt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [formatter dateFromString:time];
    model.date = date;
    
    return model;
}

@end
