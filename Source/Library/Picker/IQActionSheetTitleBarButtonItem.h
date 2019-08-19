//
//  IQActionSheetTitleBarButtonItem.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IQActionSheetTitleBarButtonItem : UIBarButtonItem

/**
 Font to be used in bar button. Default is (system font 12.0 bold).
 */
@property(nullable, nonatomic, strong) UIFont *font;

/**
 Title color to be used.
 */
@property(nullable, nonatomic, strong) UIColor *titleColor;

/**
 Initialize with frame and title.
 
 @param title Title of barButtonItem.
 */
-(nonnull instancetype)initWithTitle:(nullable NSString *)title NS_DESIGNATED_INITIALIZER;

/**
 Unavailable. Please use initWithFrame:title: method
 */
-(nonnull instancetype)init NS_UNAVAILABLE;

/**
 Unavailable. Please use initWithFrame:title: method
 */
-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Unavailable. Please use initWithFrame:title: method
 */
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end



