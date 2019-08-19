//
//  UIApplication+SlideMenuControllerOC.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "UIApplication+SlideMenuControllerOC.h"
#import "SlideMenuController.h"

@implementation UIApplication(SlideMenuControllerOC)

+(UIViewController *)topViewController:(UIViewController *)viewController {
    if (viewController == nil) {
        viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        return [UIApplication topViewController:nav.visibleViewController];
    }
    
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)viewController;
        UIViewController *selected = tab.selectedViewController;
        if (selected != nil) {
            return [UIApplication topViewController:selected];
        }
    }
    
    UIViewController *presented = viewController.presentedViewController;
    if (presented != nil) {
        return [UIApplication topViewController:presented];
    }
    
    if ([viewController isKindOfClass:[SlideMenuController class]]) {
        SlideMenuController *slide = (SlideMenuController *)viewController;
        return [UIApplication topViewController:slide.mainViewController];
    }
    
    return viewController;
}

+(UIViewController *)topViewController {
    UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    return [UIApplication topViewController:controller];
}

@end

