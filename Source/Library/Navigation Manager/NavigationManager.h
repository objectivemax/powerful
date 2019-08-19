//
//  NavigationManager.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController.h"
#import "WeatherViewController.h"
#import "LeftViewController.h"

#define NAVIGATION_MANAGER [NavigationManager sharedNavigationManager]

@interface NavigationManager : NSObject

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UIViewController *rootViewController;

+ (NavigationManager *) sharedNavigationManager;

- (void) setRootControllerWithAnimation:(UIViewController *)viewController;

- (void) setRegistration;
- (void) openMainAppInitialization;
- (void) openFirstSetupAppInitializer;

@end
