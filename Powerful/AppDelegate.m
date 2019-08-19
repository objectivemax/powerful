//
//  AppDelegate.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/25/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "AppDelegate.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if(@available(iOS 11, *)) {
        NSLog(@"iOS 11");
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateHighlighted];
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
        
    } else {
        NSLog(@"other iOS");
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60) forBarMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    }
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [FIRApp configure];

#pragma mark GOOGLE MAPS
    [GMSServices provideAPIKey:@"AIzaSyCbND122WiwUY23O18O8tY7aLRfoMiqAew"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyCbND122WiwUY23O18O8tY7aLRfoMiqAew"];
    
#pragma mark ADMob
//    [GADMobileAds configureWithApplicationID:@"ca-app-pub-8247492272574388~1182280460"];
    
    
    [CommonData initCommon];
    NSLog(@"\nTOKEN %@\nUSER_ID: %@", SECRET_TOKEN, SECRET_USER_ID);
    
    NAVIGATION_MANAGER.window = self.window;
    
    if (!SECRET_USER_ID) {

        [NAVIGATION_MANAGER setRegistration];
        NSLog(@"LOGIN storyboard");

    } else {

        [NAVIGATION_MANAGER openMainAppInitialization];
        NSLog(@"MAIN storyboard");
    }
    
    
#pragma mark SLIDE MENU
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
//                                                             bundle: nil];
//    
//    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
//                                                                 instantiateViewControllerWithIdentifier: @"leftMenuViewController"];
//    
//    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
//    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
