//
//  UIViewController+SlideMenuControllerOC.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "UIViewController+SlideMenuControllerOC.h"
#import "SlideMenuController.h"

@implementation UIViewController (SlideMenuControllerOC)

-(void)setNavigationBarItem {
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"menu.png"]];
    //[self addRightBarButtonWithImage:[UIImage imageNamed:@"ic_notifications_black_24dp"]];
    [self.slideMenuController removeLeftGestures];
    [self.slideMenuController removeRightGestures];
    [self.slideMenuController addLeftGestures];
    [self.slideMenuController addRightGestures];
}

-(void)removeNavigationBarItem {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    [self.slideMenuController removeLeftGestures];
    [self.slideMenuController removeRightGestures];
}

@end
