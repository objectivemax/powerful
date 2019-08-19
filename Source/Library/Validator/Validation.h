//
//  Validation.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/15/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Validation : NSObject

+ (BOOL)isValidEmailAddress:(NSString *) emailAddress;

+ (BOOL)validateEmail:(NSString*) emailAddress;

+ (BOOL)validatePhone:(NSString *)phoneNumber;

@end

NS_ASSUME_NONNULL_END
