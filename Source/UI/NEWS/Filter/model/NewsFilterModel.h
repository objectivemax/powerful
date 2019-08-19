//
//  NewsFilterModel.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface NewsFilterModel : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *sourceID;
@property (strong, nonatomic) NSString *sourceName;
@property (strong, nonatomic) NSString *sourceDescription;
@property (strong, nonatomic) NSURL *sourceURL;
@property (strong, nonatomic) NSString *sourceCategory;
@property (strong, nonatomic) NSString *sourceLang;
@property (strong, nonatomic) NSString *sourceCountry;
@property (assign, nonatomic) BOOL isSubscribe;

+(NSArray *)getObjectFromArray:(NSArray *)data;
+(NewsFilterModel *)sourceFromDictionary:(NSDictionary *)data;
- (void) subscribeAction;

@end

NS_ASSUME_NONNULL_END
