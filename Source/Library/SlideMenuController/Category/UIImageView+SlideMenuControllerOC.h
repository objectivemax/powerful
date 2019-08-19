//
//  UIImageView+SlideMenuControllerOC.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SlideMenuControllerOC)

-(void)setRandomDownloadImage:(int)width height:(int)height;

-(void)clipParallaxEffec:(UIImage *)baseImage screenSize:(CGSize)screenSize displayHeight:(CGFloat)displayHeight;

@end
