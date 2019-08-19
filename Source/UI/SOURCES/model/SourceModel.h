//
//  SourceModel.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/29/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SourceModel : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSString *sourceID;
@property (strong, nonatomic) NSString *sourceName;
@property (strong, nonatomic) NSString *sourceDescription;
@property (strong, nonatomic) NSURL *sourceURL;
@property (strong, nonatomic) NSString *sourceCategory;
@property (strong, nonatomic) NSString *sourceLang;
@property (strong, nonatomic) NSString *sourceCountry;
@property (assign, nonatomic) BOOL isSubscribe;

+(NSArray *)getObjectFromArray:(NSArray *)data;
+(SourceModel *)sourceFromDictionary:(NSDictionary *)data;

@end

// example responce

//"sources": [
//            -{
//                "id": "abc-news",
//                "name": "ABC News",
//                "description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
//                "url": "http://abcnews.go.com",
//                "category": "general",
//                "language": "en",
//                "country": "us"
//            },

