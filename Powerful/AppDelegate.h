//
//  AppDelegate.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/25/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuController.h"
#import "LeftViewController.h"
#import "NavigationManager.h"
#import <GoogleMaps/GoogleMaps.h>

@import GoogleMaps;
@import GooglePlaces;
@import UIKit;
@import Firebase;
@import GoogleMobileAds;

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

