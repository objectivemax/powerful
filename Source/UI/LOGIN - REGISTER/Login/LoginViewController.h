//
//  LoginViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/12/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectColor.h"
#import "Validation.h"
#import <FirebaseStorage/FirebaseStorage.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "NavigationManager.h"
@import Firebase;

@class GPPSignInButton;


NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButtonOutlet;
- (IBAction)loginButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (strong, nonatomic) UIButton *hideShow;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;

@property (assign, nonatomic) CGRect containerFrame;


@end

NS_ASSUME_NONNULL_END
