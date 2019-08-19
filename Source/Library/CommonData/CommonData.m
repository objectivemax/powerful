//
//  CommonData.m
//  Powerful
//
//  Created by Maxim Ohrimenko on 8/19/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "CommonData.h"

NSString * SECRET_TOKEN;
NSString * SECRET_USER_ID;

// COMPANY INFORMATION
BOOL INTERNET_CONNECTION;
NSString * ROLE;
NSString * COMPANY_ID;
NSString * COMPANY_NAME;
NSString * COMPANY_STREET1;
NSString * COMPANY_STREET2;
NSString * COMPANY_CITY;
NSString * COMPANY_STATE;
NSString * COMPANY_COUNTRY;

@implementation CommonData

+ (void)initCommon
{
    SECRET_TOKEN = [[NSUserDefaults standardUserDefaults] objectForKey:@"secret_token"];
    SECRET_USER_ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"secret_user_id"];
    
    // COMPANY INFORMATION
    INTERNET_CONNECTION = [[NSUserDefaults standardUserDefaults] boolForKey:@"internet_connection"];
    ROLE = [[NSUserDefaults standardUserDefaults] objectForKey:@"role"];
    COMPANY_ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_id"];
    COMPANY_NAME = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_name"];
    COMPANY_STREET1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_street1"];
    COMPANY_STREET2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_street2"];
    COMPANY_CITY = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_city"];
    COMPANY_STATE = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_state"];
    COMPANY_COUNTRY = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_country"];
    
}

+ (void)setToken:(NSString *)token {
    SECRET_TOKEN = token;
    
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"secret_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setUserId:(NSString *)userId {
    SECRET_USER_ID = userId;
    
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"secret_user_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



// COMPANY INFORMATION
+ (void)setInternetConnection:(BOOL)internetConnection {
    INTERNET_CONNECTION = internetConnection;
    
    [[NSUserDefaults standardUserDefaults] setBool:internetConnection forKey:@"internet_connection"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setRole:(NSString *)role {
    ROLE = role;
    
    [[NSUserDefaults standardUserDefaults] setValue:role forKey:@"role"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCompanyID:(NSString *)companyID {
    COMPANY_ID = companyID;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyID forKey:@"company_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCompanyName:(NSString *)companyName {
    COMPANY_NAME = companyName;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyName forKey:@"company_name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCompanyStreet1:(NSString *)companyStreet1 {
    COMPANY_STREET1 = companyStreet1;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyStreet1 forKey:@"company_street1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCompanyStreet2:(NSString *)companyStreet2 {
    COMPANY_STREET2 = companyStreet2;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyStreet2 forKey:@"company_street2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (void)setCompanyCity:(NSString *)companyCity {
    COMPANY_CITY = companyCity;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyCity forKey:@"company_city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCompanyState:(NSString *)companyState {
    COMPANY_STATE = companyState;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyState forKey:@"company_state"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCompanyCountry:(NSString *)companyCountry{
    COMPANY_COUNTRY = companyCountry;
    
    [[NSUserDefaults standardUserDefaults] setValue:companyCountry forKey:@"company_country"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

