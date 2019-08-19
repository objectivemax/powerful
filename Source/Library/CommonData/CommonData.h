//
//  CommonData.h
//  Powerful
//
//  Created by Maxim Ohrimenko on 8/19/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * SECRET_TOKEN;
FOUNDATION_EXPORT NSString * SECRET_USER_ID;

// COMPANY INFORMATION
FOUNDATION_EXPORT BOOL INTERNET_CONNECTION;
FOUNDATION_EXPORT NSString * ROLE;
FOUNDATION_EXPORT NSString * COMPANY_ID;
FOUNDATION_EXPORT NSString * COMPANY_NAME;
FOUNDATION_EXPORT NSString * COMPANY_STREET1;
FOUNDATION_EXPORT NSString * COMPANY_STREET2;
FOUNDATION_EXPORT NSString * COMPANY_CITY;
FOUNDATION_EXPORT NSString * COMPANY_STATE;
FOUNDATION_EXPORT NSString * COMPANY_COUNTRY;


@interface CommonData : NSObject

+ (void)initCommon;
+ (void)setToken:(NSString *)token;
+ (void)setUserId:(NSString *)userId;

// COMPANY INFORMATION
+ (void)setInternetConnection:(BOOL)internetConnection;
+ (void)setRole:(NSString *)role;
+ (void)setCompanyID:(NSString *)companyID;
+ (void)setCompanyName:(NSString *)companyName;
+ (void)setCompanyStreet1:(NSString *)companyStreet1;
+ (void)setCompanyStreet2:(NSString *)companyStreet2;
+ (void)setCompanyCity:(NSString *)companyCity;
+ (void)setCompanyState:(NSString *)companyState;
+ (void)setCompanyCountry:(NSString *)companyCountry;

@end
