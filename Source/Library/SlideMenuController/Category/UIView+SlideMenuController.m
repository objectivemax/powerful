//
//  UIView+SlideMenuController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "UIView+SlideMenuController.h"

@implementation UIView (SlideMenuController)

+(UIView *)loadNib:(Class) aClass {
    NSString *className = NSStringFromClass(aClass);
    return (UIView *)[[[NSBundle bundleForClass:aClass] loadNibNamed:className owner:nil options:nil] firstObject];
}

+(UIView *)loadNib {
    return [UIView loadNib:self];
}

@end
