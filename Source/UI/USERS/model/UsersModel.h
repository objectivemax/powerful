//
//  UsersModel.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/30/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UsersModel : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *image;

+(NSArray *)getObjectFromArray:(NSArray *)data;
+(UsersModel *)usersFromDictionary:(NSDictionary *)data;
@end

