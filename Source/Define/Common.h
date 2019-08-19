//
//  Common.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/15/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define    MSharedApplication        [UIApplication sharedApplication]
#define    appDelegate              (AppDelegate *)[[UIApplication sharedApplication] delegate]

// UI Helpers

#define    IsPortrait               UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation)
#define    IsLandscape              UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)

#define    WINDOW_WIDTH             [UIScreen mainScreen].bounds.size.width    ///< i.e. for iPhone it is 320 for portrait and 300 for landscape orientation
#define    WINDOW_HEIGHT            [UIScreen mainScreen].bounds.size.height   ///< i.e. for iPhone it is 460 for portrait and 480 for landscape orientation
#define    WINDOW_WIDTH_ORIENTED    (IsPortrait ? WINDOW_WIDTH : WINDOW_HEIGHT)          ///< i.e. 320 for portrait and 480 for landscape orientation
#define    WINDOW_HEIGHT_ORIENTED   (IsPortrait ? WINDOW_HEIGHT : WINDOW_WIDTH)          ///< i.e. 460 for portrait and 320 for landscape orientation

#define    SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define    SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height
#define    SCREEN_WIDTH_ORIENTED    (IsPortrait ? SCREEN_WIDTH : SCREEN_HEIGHT)
#define    SCREEN_HEIGHT_ORIENTED   (IsPortrait ? SCREEN_HEIGHT : SCREEN_WIDTH)

// For UI elements
#define    LEFT 16
#define    RIGHT 16
#define    TOP 10
#define    TITLE_HEIGHT 22
#define    SEPARATOR_HEIGHT 0.5
#define    CELL_HEIGHT_STANDART 44
#define    CELL_HEIGHT_BIG 60
#define    ICON_SIZE 24
#define    TEXT_FIELD_HEIGHT 42
#define    BUTTON_HEIGHT 44
#define    PHOTO_VIEW_SIZE 150



#define    NAVBAR_HEIGHT            (IsLandscape && IsIPhone ? 32. : 44.)
#define    TOOLBAR_HEIGHT           44.
#define    TABBAR_HEIGHT            49.

#define    KEYBOARD_SIZE_PORTRAIT   (IsIPhone ? CGSizeMake(320, 216) : CGSizeMake(768, 264))
#define    KEYBOARD_SIZE_LANDSCAPE  (IsIPhone ? CGSizeMake(480, 162) : CGSizeMake(1024, 352))
#define    KEYBOARD_SIZE            (IsPortrait ? KEYBOARD_SIZE_PORTRAIT : KEYBOARD_SIZE_LANDSCAPE)

#define    AUTORESIZE_CENTER        (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)
#define    AUTORESIZE_STRETCH       (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

// Debug functions
#pragma mark - Debug functions

#define   SHOW_LOGS             NO
#define   SHOW_TEXTURES_LOGS    NO
#define   Log(format, ...)      if (SHOW_LOGS) NSLog(@"%s: %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:format, ## __VA_ARGS__]);
#define   TexLog(format, ...)   if (SHOW_LOGS && SHOW_TEXTURES_LOGS) NSLog(@"%s: %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:format, ## __VA_ARGS__]);
#define   Error(format, ...)    if (SHOW_LOGS) NSLog(@"ERROR: %@", [NSString stringWithFormat:format, ## __VA_ARGS__]);
#define   Mark                  if (SHOW_LOGS) NSLog(@"%s", __PRETTY_FUNCTION__);

// Hardware Info
#pragma mark - Hardware Info

#define   SYSTEM_VERSION  [[UIDevice currentDevice] systemVersion]

#define   SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define   IsIOS8          (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
#define   IsIOS9          (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))

#define   IsIPad          isIPad()
#define   IsIPhone        !isIPad()
#define   IsRetina        isRetina()

// Default Paths
#pragma mark - Paths

#define   BundlePath                    [[NSBundle mainBundle] resourcePath]
#define   PathToResource(resourceName)  [BundlePath stringByAppendingPathComponent:resourceName]

#define   DocumentsPath                 [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define   LibraryPath                   [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define   SharedDataPath                DocumentsPath

#define   CriticalDataPath              criticalDataPath()
#define   OfflineDataPath               offlineDataPath()
#define   CachedDataPath                [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define   TemporaryDataPath             [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]

// Misc
#pragma mark - Misc

#define   Localized(string)         NSLocalizedString(string, @"")

#define   CGRectGetCenter(rect)     CGPointMake(floorf(0.5 * rect.size.width), floorf(0.5 * rect.size.height))
#define   CGRectGetMidPoint(rect)   CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))

#define   CGAffineTransformGetScale(transform)        CGPointMake(sqrtf(transform.a * transform.a + transform.c * transform.c), sqrtf(transform.b * transform.b + transform.d * transform.d))
#define   CGAffineTransformGetRotateAngle(transform)  atan2f(transform.b, transform.a)

#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

BOOL isIPad();
BOOL isRetina();

NSString *criticalDataPath();

id loadNib(Class aClass, NSString *nibName, id owner);

CGSize CGSizeScaledToFitSize(CGSize size1, CGSize size2);
CGSize CGSizeScaledToFillSize(CGSize size1, CGSize size2);
CGRect CGRectWithSize(CGSize size);
CGRect CGRectFillRect(CGRect rect1, CGRect rect2);

CGRect CGRectExpandToLabel(UILabel *label);

void ShowAlert(NSString *title, NSString *message);

NSString * DeviceUDID();

