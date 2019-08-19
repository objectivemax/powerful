//
//  StartViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/12/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@interface PrivateTransitionContext : NSObject <UIViewControllerContextTransitioning>
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight; /// Designated initializer.
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete); /// A block of code we can set to execute after having received the completeTransition: message.
@property (nonatomic, assign, getter=isAnimated) BOOL animated; /// Private setter for the animated property.
@property (nonatomic, assign, getter=isInteractive) BOOL interactive; /// Private setter for the interactive property.
@end

/** Instances of this private class perform the default transition animation which is to slide child views horizontally.
 @note The class only supports UIViewControllerAnimatedTransitioning at this point. Not UIViewControllerInteractiveTransitioning.
 */
@interface PrivateAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>
@end

@implementation StartViewController {
    BOOL clicked;
}
@synthesize loginSwitch, registerSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [ProjectColor myLightBlueColor];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 4);
    self.containerView.layer.shadowOpacity = 0.5;
    self.containerView.layer.shadowRadius = 2;
    
    clicked = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    loginSwitch = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    registerSwitch = [storyboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    
//    [loginSwitch removeFromParentViewController];
//    [loginSwitch.view removeFromSuperview];
//    [self addChildViewController:loginSwitch];
//    [self fullFillToBottomView:loginSwitch.view];
//
//    loginSwitch.containerFrame = self.containerView.frame;
    
    self.clickOutlet.backgroundColor = [ProjectColor myBlueColor];
    self.clickOutlet.layer.cornerRadius = self.clickOutlet.frame.size.height/2 - 0.5;
    [self.clickOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Register"] forState:UIControlStateNormal];
    self.clickOutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.clickOutlet.layer.shadowOffset = CGSizeMake(0, 2);
    self.clickOutlet.layer.shadowOpacity = 0.7;
    self.clickOutlet.layer.shadowRadius = 4;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [loginSwitch removeFromParentViewController];
    [loginSwitch.view removeFromSuperview];
    [self addChildViewController:loginSwitch];
    [self fullFillToBottomView:loginSwitch.view];
    
    loginSwitch.containerFrame = loginSwitch.view.frame;
    registerSwitch.containerFrame = loginSwitch.view.frame;
}



- (void) fullFillToBottomView:(UIView *)subView {
    [self.containerView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (IBAction)clickAction:(id)sender {
    
    [self.clickOutlet setEnabled:NO];

    if(!clicked) {
        
        [self.clickOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Login"] forState:UIControlStateNormal];
        
        if ([self.delegate respondsToSelector:@selector (containerViewController:didSelectViewController:)]) {
            [self.delegate containerViewController:self didSelectViewController:registerSwitch];
        }
        
        clicked = YES;
        
        [loginSwitch willMoveToParentViewController:nil];
        [self addChildViewController:registerSwitch];
        [self fullFillToBottomView:registerSwitch.view];
        
//        registerSwitch.containerFrame = self.containerView.frame;
        
        id<UIViewControllerAnimatedTransitioning>animator = nil;
        if ([self.delegate respondsToSelector:@selector (containerViewController:animationControllerForTransitionFromViewController:toViewController:)]) {
            animator = [self.delegate containerViewController:self animationControllerForTransitionFromViewController:loginSwitch toViewController:registerSwitch];
        }
        animator = (animator ?: [[PrivateAnimatedTransition alloc] init]);
        
        // Because of the nature of our view controller, with horizontally arranged buttons, we instantiate our private transition context with information about whether this is a left-to-right or right-to-left transition. The animator can use this information if it wants.
        NSUInteger fromIndex = 0;
        NSUInteger toIndex = 1;
        PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:loginSwitch toViewController:registerSwitch goingRight:toIndex > fromIndex];
        
        transitionContext.animated = YES;
        transitionContext.interactive = NO;
        transitionContext.completionBlock = ^(BOOL didComplete) {
            [self->loginSwitch.view removeFromSuperview];
            [self->loginSwitch removeFromParentViewController];
            [self->loginSwitch didMoveToParentViewController:self];
            
            [self.clickOutlet setEnabled:YES];
            
            if ([animator respondsToSelector:@selector (animationEnded:)]) {
                [animator animationEnded:didComplete];
            }
            //        self.privateButtonsView.userInteractionEnabled = YES;
        };
        
        //    self.privateButtonsView.userInteractionEnabled = NO; // Prevent user tapping buttons mid-transition, messing up state
        [animator animateTransition:transitionContext];
        
    } else {

        [self.clickOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Register"] forState:UIControlStateNormal];
        
        if ([self.delegate respondsToSelector:@selector (containerViewController:didSelectViewController:)]) {
            [self.delegate containerViewController:self didSelectViewController:loginSwitch];
        }
        
    
        [registerSwitch willMoveToParentViewController:nil];
        [self addChildViewController:loginSwitch];
        [self fullFillToBottomView:loginSwitch.view];
        
//        loginSwitch.containerFrame = self.containerView.frame;
        
        id<UIViewControllerAnimatedTransitioning>animator = nil;
        if ([self.delegate respondsToSelector:@selector (containerViewController:animationControllerForTransitionFromViewController:toViewController:)]) {
            animator = [self.delegate containerViewController:self animationControllerForTransitionFromViewController:registerSwitch toViewController:loginSwitch];
        }
        animator = (animator ?: [[PrivateAnimatedTransition alloc] init]);
        
        // Because of the nature of our view controller, with horizontally arranged buttons, we instantiate our private transition context with information about whether this is a left-to-right or right-to-left transition. The animator can use this information if it wants.
        NSUInteger fromIndex = 1;
        NSUInteger toIndex = 0;
        PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:registerSwitch toViewController:loginSwitch goingRight:toIndex > fromIndex];
        
        transitionContext.animated = YES;
        transitionContext.interactive = NO;
        transitionContext.completionBlock = ^(BOOL didComplete) {
            [self->registerSwitch.view removeFromSuperview];
            [self->registerSwitch removeFromParentViewController];
            [self->registerSwitch didMoveToParentViewController:self];
            
            [self.clickOutlet setEnabled:YES];
            
            if ([animator respondsToSelector:@selector (animationEnded:)]) {
                [animator animationEnded:didComplete];
            }
            //        self.privateButtonsView.userInteractionEnabled = YES;
        };
        
        //    self.privateButtonsView.userInteractionEnabled = NO; // Prevent user tapping buttons mid-transition, messing up state
        [animator animateTransition:transitionContext];
        
        //
        clicked = NO;

        
    }
    
    
}
@end

#pragma mark - Private Transitioning Classes

@interface PrivateTransitionContext ()
@property (nonatomic, strong) NSDictionary *privateViewControllers;
@property (nonatomic, assign) CGRect privateDisappearingFromRect;
@property (nonatomic, assign) CGRect privateAppearingFromRect;
@property (nonatomic, assign) CGRect privateDisappearingToRect;
@property (nonatomic, assign) CGRect privateAppearingToRect;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@end

@implementation PrivateTransitionContext

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight {
    NSAssert ([fromViewController isViewLoaded] && fromViewController.view.superview, @"The fromViewController view must reside in the container view upon initializing the transition context.");
    
    if ((self = [super init])) {
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.privateViewControllers = @{
                                        UITransitionContextFromViewControllerKey:fromViewController,
                                        UITransitionContextToViewControllerKey:toViewController,
                                        };
        
        // Set the view frame properties which make sense in our specialized ContainerViewController context. Views appear from and disappear to the sides, corresponding to where the icon buttons are positioned. So tapping a button to the right of the currently selected, makes the view disappear to the left and the new view appear from the right. The animator object can choose to use this to determine whether the transition should be going left to right, or right to left, for example.
        CGFloat travelDistance = (goingRight ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width);
        self.privateDisappearingFromRect = self.privateAppearingToRect = self.containerView.bounds;
        self.privateDisappearingToRect = CGRectOffset (self.containerView.bounds, travelDistance, 0);
        self.privateAppearingFromRect = CGRectOffset (self.containerView.bounds, -travelDistance, 0);
    }
    
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingFromRect;
    } else {
        return self.privateAppearingFromRect;
    }
}

- (CGRect)finalFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingToRect;
    } else {
        return self.privateAppearingToRect;
    }
}

- (UIViewController *)viewControllerForKey:(NSString *)key {
    return self.privateViewControllers[key];
}

- (void)completeTransition:(BOOL)didComplete {
    if (self.completionBlock) {
        self.completionBlock (didComplete);
    }
}

- (BOOL)transitionWasCancelled { return NO; } // Our non-interactive transition can't be cancelled (it could be interrupted, though)

// Supress warnings by implementing empty interaction methods for the remainder of the protocol:

- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {}
- (void)cancelInteractiveTransition {}

@end

@implementation PrivateAnimatedTransition

static CGFloat const kChildViewPadding = 16;
static CGFloat const kDamping = 20;
static CGFloat const kInitialSpringVelocity = 0.5;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

/// Slide views horizontally, with a bit of space between, while fading out and in.
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // When sliding the views horizontally in and out, figure out whether we are going left or right.
    BOOL goingRight = ([transitionContext initialFrameForViewController:toViewController].origin.x < [transitionContext finalFrameForViewController:toViewController].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width + kChildViewPadding;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingRight ? travelDistance : -travelDistance, 0);
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    toViewController.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:kDamping initialSpringVelocity:kInitialSpringVelocity options:0x00 animations:^{
        fromViewController.view.transform = travel;
        fromViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
