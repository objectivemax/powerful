//
//  RegisterViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/12/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "RegisterViewController.h"

#define TEXT_FIELD_HEIGHT 42
#define BUTTON_HEIGHT 44
#define ICON_SIZE 24
#define ICON_MARGIN 4
#define ICON_TOP 9

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize ref, handle;

static NSString * const kClientId = @"427625535549-af09rjhcmfri73luch22dgbnirmui12g.apps.googleusercontent.com";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ref = [[FIRDatabase databaseWithURL:@"https://first-ios-firebase-d4cda.firebaseio.com/"] reference];
    ref = [[FIRDatabase database] reference];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self initMainViewComponents];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmPassTextField resignFirstResponder];
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
    
    
    // left icon
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICON_MARGIN + ICON_SIZE + ICON_MARGIN, TEXT_FIELD_HEIGHT)];
    UIImageView *passIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_MARGIN, ICON_TOP, ICON_SIZE, ICON_SIZE)];
    passIcon.image = [UIImage imageNamed:@"lock.png"];
    [passView addSubview:passIcon];
    self.passwordTextField.leftView = passView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    // CONFIRM PASSWORD TEXT FIELD
    self.confirmPassTextField.secureTextEntry = YES;
    self.confirmPassTextField.delegate = self;
    self.confirmPassTextField.layer.cornerRadius = 8;
    self.confirmPassTextField.layer.masksToBounds = YES;
    self.confirmPassTextField.layer.borderWidth = 1;
    self.confirmPassTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.confirmPassTextField.textColor = [UIColor blackColor];
    self.confirmPassTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.confirmPassTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                               string:@"confirm your password"];
    
    // left icon
    UIImageView *confPassView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICON_MARGIN + ICON_SIZE + ICON_MARGIN, TEXT_FIELD_HEIGHT)];
    UIImageView *confPassIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_MARGIN, ICON_TOP, ICON_SIZE, ICON_SIZE)];
    confPassIcon.image = [UIImage imageNamed:@"lock.png"];
    [confPassView addSubview:confPassIcon];
    self.confirmPassTextField.leftView = confPassView;
    self.confirmPassTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    // ERROR LABEL
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    
    
    // REGISTER BUTTON
    self.registerButtonOutlet.backgroundColor = [ProjectColor myRedColor];
    self.registerButtonOutlet.layer.cornerRadius = self.registerButtonOutlet.frame.size.height/2 - 0.5;
    [self.registerButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Register"] forState:UIControlStateNormal];
    self.registerButtonOutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.registerButtonOutlet.layer.shadowOffset = CGSizeMake(0, 2);
    self.registerButtonOutlet.layer.shadowOpacity = 0.7;
    self.registerButtonOutlet.layer.shadowRadius = 4;
    
}



- (IBAction)registerButton:(id)sender {
    if ([Validation validateEmail:self.emailTextField.text] && self.passwordTextField.text.length > 5 && self.confirmPassTextField.text.length > 5 && [self.passwordTextField.text isEqualToString: self.confirmPassTextField.text]) {
        
        [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            NSLog(@"reg");
            
            if (!error) {
                self.handle = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
                    
                    NSDictionary *dict = @{@"email": self.emailTextField.text,
                                           @"password": self.passwordTextField.text,
                                           @"first_setup": @"0"};
                    NSLog(@"dict :%@", dict);
                    
                    [[[self->ref child:@"users"] child:user.uid] setValue:dict];

                    // save temp UID
                    [[NSUserDefaults standardUserDefaults] setObject:user.uid forKey:@"temp_uid"];
                    [[NSUserDefaults standardUserDefaults] setObject:self.emailTextField.text forKey:@"temp_uemail"];
                    [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"temp_upass"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [NAVIGATION_MANAGER openFirstSetupAppInitializer];
                }];
            } else {
                NSLog(@"error :%@", error);
                self.errorLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor redColor] string:[error localizedDescription]];
            }
        }];
        
    } else {
        
        self.errorLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor redColor] string:@"Error. Please enter correct email or password."];
        
    }
}

@end
