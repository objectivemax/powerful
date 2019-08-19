//
//  AttributedString.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/27/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttributedString : NSObject


// HEADLINE
+ (NSAttributedString *) headlineASWithColor:(UIColor *)color string:(NSString *)string;

//// HEADLINE2
//- (NSAttributedString *) headline2AttributedStringWithColor:(UIColor *)color string:(NSString *)string;

// BODY
+ (NSAttributedString *) bodyASWithColor:(UIColor *)color string:(NSString *)string;

// SUBHEAD
+ (NSAttributedString *) subheadASWithColor:(UIColor *)color string:(NSString *)string;

// FOOTNOTE
+ (NSAttributedString *) footnoteASWithColor:(UIColor *)color string:(NSString *)string;

//// LARGE TITLE
//- (NSAttributedString *) largeTitleAttributedStringWithColor:(UIColor *)color string:(NSString *)string;

// BADGE
+ (NSAttributedString *) badgeASWithColor:(UIColor *)color string:(NSString *)string;

//// FOOTNOTE 2
//- (NSAttributedString *) footnote2AttributedStringWithColor:(UIColor *)color string:(NSString *)string;
//
//// FOOTNOTE 2 with under line
//- (NSAttributedString *) footnote2WithUnderLineAttributedStringWithColor:(UIColor *)color string:(NSString *)string;
//
//// FOOTNOTE 3
//- (NSAttributedString *) footnote3AttributedStringWithColor:(UIColor *)color string:(NSString *)string;
//
//// TITLE 3
//- (NSAttributedString *) title3AttributedStringWithColor:(UIColor *)color string:(NSString *)string;


// TITLE FOR NAVIGATION BAR
+ (NSDictionary *) titleASNavigationBar;

@end

NS_ASSUME_NONNULL_END
