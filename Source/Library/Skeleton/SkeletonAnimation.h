//
//  SkeletonAnimation.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/30/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Skeleton.h"
#import "UIView+Rect.h"

NS_ASSUME_NONNULL_BEGIN

@interface SkeletonAnimation : NSObject
+ (SkeletonAnimation *)sharedSkeletonAnimation;
- (void)beginOrEndAnimationForView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
