//
//  NavigationManager.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "NavigationManager.h"

@interface NavigationManager ()

@end

@implementation NavigationManager

+ (NavigationManager *)sharedNavigationManager {
    static dispatch_once_t onceToken;
    static NavigationManager *_sharedNavigationManager = nil;
    dispatch_once(&onceToken, ^{
        _sharedNavigationManager = [[NavigationManager alloc] init];
    });
    return _sharedNavigationManager;
}

- (void) setRootControllerWithAnimation:(UIViewController *)viewController {
    self.rootViewController = viewController;
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.window setRootViewController:viewController];
                    }
                    completion:nil];
}

- (void) setRegistration {
//    self.slideNavigationController = nil;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"startViewController"];
    [self setRootControllerWithAnimation:controller];
}

- (void) openMainAppInitialization {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewsViewController *newsController = [storyboard instantiateViewControllerWithIdentifier:@"newsViewController"];
    LeftViewController *leftViewController = (LeftViewController *)[storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:newsController];
    
    leftViewController.newsViewController = nvc;
    
    SlideMenuController *slideMenuController = [[SlideMenuController alloc] initWithMainViewController:nvc leftMenuViewController:leftViewController];
    slideMenuController.automaticallyAdjustsScrollViewInsets = YES;
    slideMenuController.delegate = newsController;
    
    [self setRootControllerWithAnimation:slideMenuController];
}


- (void) openFirstSetupAppInitializer {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"firstSetupViewController"];
    [self setRootControllerWithAnimation:controller];
}

@end
