//
//  AttributedString.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/27/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "AttributedString.h"

@implementation AttributedString

// HEADLINE
+ (NSAttributedString *) headlineASWithColor:(UIColor *)color string:(NSString *)string {
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:string
     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskUltra-Bold900" size:17],
                   NSForegroundColorAttributeName : color,
                   NSKernAttributeName : @(-0.41f) }];
    
    return attributedString;
}
//
//
//// HEADLINE2
//- (NSAttributedString *) headline2AttributedStringWithColor:(UIColor *)color string:(NSString *)string {
//    NSAttributedString *attributedString =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"SFProText-Semibold" size:20],
//                   NSForegroundColorAttributeName : color,
//                   NSKernAttributeName : @(-0.41f) }];
//    
//    return attributedString;
//}


// BODY
+ (NSAttributedString *) bodyASWithColor:(UIColor *)color string:(NSString *)string {
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:string
     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskSemi-Bold600" size:17],
                   NSForegroundColorAttributeName : color,
                   NSKernAttributeName : @(-0.41f) }];
    
    return attributedString;
}

// SUBHEAD
+ (NSAttributedString *) subheadASWithColor:(UIColor *)color string:(NSString *)string {
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:string
     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskNormal400" size:15],
                   NSForegroundColorAttributeName : color,
                   NSKernAttributeName : @(-0.24f) }];
    
    return attributedString;
}

// FOOTNOTE
+ (NSAttributedString *) footnoteASWithColor:(UIColor *)color string:(NSString *)string {
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:string
     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskUltra-Bold900" size:13],
                   NSForegroundColorAttributeName : color,
                   NSKernAttributeName : @(-0.08f) }];
    
    return attributedString;
}

//// LARGE TITLE
//- (NSAttributedString *) largeTitleAttributedStringWithColor:(UIColor *)color string:(NSString *)string {
//    NSAttributedString *attributedString =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"SFProDisplay-Bold" size:34],
//                   NSForegroundColorAttributeName : color,
//                   NSKernAttributeName : @(0.41f) }];
//    
//    return attributedString;
//}
//
// BADGE
+ (NSAttributedString *) badgeASWithColor:(UIColor *)color string:(NSString *)string {
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:string
     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskUltra-Bold900" size:11],
                   NSForegroundColorAttributeName : color,
                   NSKernAttributeName : @(0.07f) }];
    
    return attributedString;
}
//
//// FOOTNOTE 2
//- (NSAttributedString *) footnote2AttributedStringWithColor:(UIColor *)color string:(NSString *)string {
//    NSAttributedString *attributedString =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"SFProText-Semibold" size:13],
//                   NSForegroundColorAttributeName : color,
//                   NSKernAttributeName : @(-0.08f) }];
//    
//    return attributedString;
//}
//
//// FOOTNOTE 2 with under line
//- (NSAttributedString *) footnote2WithUnderLineAttributedStringWithColor:(UIColor *)color string:(NSString *)string {
//    NSAttributedString *attributedString =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"SFProText-Semibold" size:13],
//                   NSForegroundColorAttributeName : color,
//                   NSKernAttributeName : @(-0.08f),
//                   NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
//    
//    return attributedString;
//}
//
//// FOOTNOTE 3
//- (NSAttributedString *) footnote3AttributedStringWithColor:(UIColor *)color string:(NSString *)string {
//    NSAttributedString *attributedString =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"SFProText-Semibold" size:15],
//                   NSForegroundColorAttributeName : color,
//                   NSKernAttributeName : @(-0.08f) }];
//    
//    return attributedString;
//}
//
//// TITLE 3
//- (NSAttributedString *) title3AttributedStringWithColor:(UIColor *)color string:(NSString *)string {
//    NSAttributedString *attributedString =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"SFProDisplay-Bold" size:22],
//                   NSForegroundColorAttributeName : color,
//                   NSKernAttributeName : @(0.01f) }];
//    
//    return attributedString;
//}


// TITLE FOR NAVIGATION BAR
+ (NSDictionary *) titleASNavigationBar {
    NSDictionary *navigationDict = @{NSFontAttributeName : [UIFont fontWithName:@"MoskSemi-Bold600" size:17],
                                     NSForegroundColorAttributeName : [UIColor blackColor],
                                     NSKernAttributeName : @(-0.41f) };
    return navigationDict;
}



@end
