//
//  DataParser.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
//#import "SourceModel.h"
#import "NewsFilterModel.h"
#import "UsersModel.h"

@interface DataParser : NSObject

- (NSArray *)parseNews:(NSDictionary *)data;
- (NSArray *)parseFilter:(NSDictionary *)data;
- (NSArray *)parseSource:(NSDictionary *)data;
- (NSArray *)parseUsersList:(NSDictionary *)data;


@end

