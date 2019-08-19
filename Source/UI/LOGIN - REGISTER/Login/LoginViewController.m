//
//  LoginViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/12/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "LoginViewController.h"

#define TEXT_FIELD_HEIGHT 42
#define BUTTON_HEIGHT 44
#define ICON_SIZE 24
#define ICON_MARGIN 4
#define ICON_TOP 9

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize ref;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ref = [[FIRDatabase databaseWithURL:@"https://first-ios-firebase-d4cda.firebaseio.com/"] reference];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self initMainViewComponents];
}

- (void) initMainViewComponents {
    
    // MAIN VIEW
    self.mainView.backgroundColor = [UIColor clearColor];
    self.mainView.layer.cornerRadius = 50;
    self.mainView.layer.masksToBounds = YES;
    // gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.containerFrame;
    gradient.colors = @[(id)[ProjectColor myLightBlueColor].CGColor, (id)[ProjectColor myBlueColor].CGColor];
    [self.mainView.layer insertSublayer:gradient atIndex:0];
    
    
    // LOGO IMAGE VIEW
    self.logoImageView.image = [UIImage imageNamed:@"logo.png"];
    
    
    // EMAIL TEXT FIELD
    self.emailTextField.delegate = self;
    self.emailTextField.layer.cornerRadius = 8;
    self.emailTextField.layer.masksToBounds = YES;
    self.emailTextField.layer.borderWidth = 1;
    self.emailTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.emailTextField.textColor = [UIColor blackColor];
    self.emailTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.emailTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                                 string:@"your_email@mail.com"];

    // left icon
    UIImageView *emailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICON_MARGIN + ICON_SIZE + ICON_MARGIN, TEXT_FIELD_HEIGHT)];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_MARGIN, ICON_TOP, ICON_SIZE, ICON_SIZE)];
    emailIcon.image = [UIImage imageNamed:@"email.png"];
    [emailView addSubview:emailIcon];
    self.emailTextField.leftView = emailView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    // PASSWORD TEXT FIELD
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.delegate = self;
    self.passwordTextField.layer.cornerRadius = 8;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderWidth = 1;
    self.passwordTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.passwordTextField.textColor = [UIColor blackColor];
    self.passwordTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.passwordTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                               string:@"your password"];
    
    // right icon
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ICON_MARGIN + ICON_SIZE + ICON_MARGIN, TEXT_FIELD_HEIGHT)];
    self.hideShow = [[UIButton alloc] initWithFrame:CGRectMake(ICON_MARGIN, ICON_TOP, ICON_SIZE, ICON_SIZE)];
    [self.hideShow setImage:[UIImage imageNamed:@"visibility_off.png"] forState:UIControlStateNormal];
    [rightView addSubview: self.hideShow];
    
    self.passwordTextField.rightView = rightView;
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.hideShow addTarget:self action:@selector(hideShow:) forControlEvents:UIControlEventTouchUpInside];
    
    // left icon
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICON_MARGIN + ICON_SIZE + ICON_MARGIN, TEXT_FIELD_HEIGHT)];
    UIImageView *passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_MARGIN, ICON_TOP, ICON_SIZE, ICON_SIZE)];
    passIcon.image = [UIImage imageNamed:@"lock.png"];
    [passView addSubview:passIcon];
    self.passwordTextField.leftView = passView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    // ERROR LABEL
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    

    // LOGIN BUTTON
    self.loginButtonOutlet.backgroundColor = [ProjectColor myRedColor];
    self.loginButtonOutlet.layer.cornerRadius = self.loginButtonOutlet.frame.size.height/2 - 0.5;
    [self.loginButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Login"] forState:UIControlStateNormal];
    self.loginButtonOutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.loginButtonOutlet.layer.shadowOffset = CGSizeMake(0, 2);
    self.loginButtonOutlet.layer.shadowOpacity = 0.7;
    self.loginButtonOutlet.layer.shadowRadius = 4;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)hideShow:(id)sender {
    if (!self.passwordTextField.secureTextEntry) {
        
        self.passwordTextField.secureTextEntry = YES;
        [self.hideShow setImage:[UIImage imageNamed:@"visibility_off.png"] forState:UIControlStateNormal];
        
    } else {
        
        self.passwordTextField.secureTextEntry = NO;
        [self.hideShow setImage:[UIImage imageNamed:@"visibility_on.png"] forState:UIControlStateNormal];

    }
    [self.passwordTextField becomeFirstResponder];
}


- (IBAction)loginButtonAction:(id)sender {
    NSLog(@"\nemail: %@\npass: %@", self.emailTextField.text, self.passwordTextField.text);
    
    
    if ([Validation validateEmail:self.emailTextField.text] && self.passwordTextField.text.length > 5) {
        
        [[FIRAuth auth] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {

            if (authResult.user.uid != NULL){
                NSLog(@"user uid: %@", authResult.user.uid);
                NSLog(@"user email: %@", [authResult.user valueForKey:@"email"]);
                
                [self checkUserToFirstSetup:authResult.user.uid];
            } else {
                NSLog(@"ERROR == %@", error);

                self.errorLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor redColor] string:@"Sorry. Not find in our database."];
                
            }
        }];
        
    } else {
        
        self.errorLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor redColor] string:@"Error. Please enter correct email or password."];
    }
}



- (void) checkUserToFirstSetup:(NSString *)user_uid {
    [[[self.ref child:@"users"] child:user_uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSInteger fisrtSetup = [[snapshot.value valueForKey:@"first_setup"] integerValue];
        
        if (fisrtSetup == 0) {
            // save temp UID
            [[NSUserDefaults standardUserDefaults] setObject:user_uid forKey:@"temp_uid"];
            [[NSUserDefaults standardUserDefaults] setObject:self.emailTextField.text forKey:@"temp_uemail"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"temp_upass"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [NAVIGATION_MANAGER openFirstSetupAppInitializer];
        } else {
            // save UID
            [CommonData setUserId:user_uid];
            NSLog(@"UID: %@", SECRET_USER_ID);
            
            [NAVIGATION_MANAGER openMainAppInitialization];
        }
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"CANCEL BLOCK %@", error.localizedDescription);
    }];

}




@end
