//
//  NewsModel.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface NewsModel : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *sourceID;
@property (strong, nonatomic) NSString *sourceName;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descript;
@property (strong, nonatomic) NSURL *urlInfo;
@property (strong, nonatomic) NSData *dataPic;
@property (strong, nonatomic) NSDate *date;

+(NSArray *)getObjectFromArray:(NSArray *)data;
+(NewsModel *)newsFromDictionary:(NSDictionary *)data;

@end

//-"source": {
//"id": "the-verge",
//"name": "The Verge"
//},
//"author": "Nick Statt",
//"title": "The Verge 2017 tech report card: Twitter",
//"description": "Trump’s first year as POTUS was a tough one for Twitter",
//"url": "https://www.theverge.com/2017/12/28/16820536/2017-tech-recap-twitter-trump-harassment-policy-controversy",
//"urlToImage": "https://cdn.vox-cdn.com/thumbor/rIx63ABhn4LDM1v2ixfC8xGRcbQ=/0x146:2040x1214/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/8966105/acastro_170726_1777_0010.jpg",
//"publishedAt": "2017-12-28T15:00:01Z"

