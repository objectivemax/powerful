//
//  ProfileViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController {
    NSString *firstNameString;
    NSString *lastNameString;
    NSString *countryString;
    NSString *cityString;
    NSString *emailString;
    NSString *dateOfBirthString;
    NSString *phoneString;
    NSString *passwordString;
}
@synthesize cityArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [ProjectColor myLightBlueColor];
    
    self.ref = [[FIRDatabase database] reference];
    
    // Navigation Title
    self.navigationItem.title = @"Profile";
    self.navigationController.navigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];
    
    [self getUserInfo];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarItem];
}


- (void) initComponents {
    
    // full name label
    self.fullNameLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Full Name *"];
    
    // first name text field
    self.firstNameTextField.delegate = self;
    self.firstNameTextField.backgroundColor = [UIColor clearColor];
    self.firstNameTextField.layer.cornerRadius = 4.0f;
    self.firstNameTextField.layer.masksToBounds = YES;
    self.firstNameTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.firstNameTextField.layer.borderWidth = 1.0f;
    self.firstNameTextField.textColor = [UIColor blackColor];
    self.firstNameTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.firstNameTextField.attributedText =
    [AttributedString bodyASWithColor:[UIColor blackColor] string:self->firstNameString];
    self.firstNameTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                               string:@"First Name"];
    // add devider view to FIRST NAME TEXT FIELD
    UIView *firstNameDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.firstNameTextField.leftView = firstNameDeviderView;
    self.firstNameTextField.leftViewMode = UITextFieldViewModeAlways;

    // last name
    self.lastNameTextField.delegate = self;
    self.lastNameTextField.backgroundColor = [UIColor clearColor];
    self.lastNameTextField.layer.cornerRadius = 4.0f;
    self.lastNameTextField.layer.masksToBounds = YES;
    self.lastNameTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.lastNameTextField.layer.borderWidth = 1.0f;
    self.lastNameTextField.textColor = [UIColor blackColor];
    self.lastNameTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.lastNameTextField.attributedText =
    [AttributedString bodyASWithColor:[UIColor blackColor] string:self->lastNameString];
    self.lastNameTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                               string:@"Last Name"];
    // add devider view to LAST NAME TEXT FIELD
    UIView *lastNameDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.lastNameTextField.leftView = lastNameDeviderView;
    self.lastNameTextField.leftViewMode = UITextFieldViewModeAlways;

    
    
    // country label
    self.countryLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Country *"];
    
    
    // city label
    self.cityLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"City *"];
    
    
    // country button
    self.countryButtonOutlet.layer.cornerRadius = self.countryButtonOutlet.frame.size.height/2 - 0.5;
    self.countryButtonOutlet.backgroundColor = [ProjectColor myBlueColor];
    [self.countryButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:self->countryString] forState:UIControlStateNormal];
    
    
    // city button
    self.cityButtonOutlet.layer.cornerRadius = self.cityButtonOutlet.frame.size.height/2 - 0.5;
    self.cityButtonOutlet.backgroundColor = [ProjectColor myBlueColor];
    [self.cityButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:self->cityString] forState:UIControlStateNormal];
    
    
    // phone label
    self.phoneLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Phone *"];
    
    // phone text field
    self.phoneTextField.delegate = self;
    self.phoneTextField.tag = 1000;
    self.phoneTextField.backgroundColor = [UIColor clearColor];
    self.phoneTextField.layer.cornerRadius = 4.0f;
    self.phoneTextField.layer.masksToBounds = YES;
    self.phoneTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.phoneTextField.layer.borderWidth = 1.0f;
    self.phoneTextField.textColor = [UIColor blackColor];
    self.phoneTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.phoneTextField.attributedText =
    [AttributedString bodyASWithColor:[UIColor blackColor] string:self->phoneString];
    self.phoneTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30] string:@"+380901234567"];
    
    // add devider view to PHONE TEXT FIELD
    UIView *phoneDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.phoneTextField.leftView = phoneDeviderView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    // date of birth label
    self.dateOfBirthLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Date of birth *"];
    
    // date of birth button
    self.dateOfBirthButtonOutlet.layer.cornerRadius = self.dateOfBirthButtonOutlet.frame.size.height/2 - 0.5;
    self.dateOfBirthButtonOutlet.backgroundColor = [ProjectColor myBlueColor];
    [self.dateOfBirthButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:self->dateOfBirthString] forState:UIControlStateNormal];
    
    
    // email label
    self.emailLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Email *"];
    
    // email text field
    self.emailTextField.delegate = self;
    self.emailTextField.backgroundColor = [UIColor clearColor];
    self.emailTextField.layer.cornerRadius = 4.0f;
    self.emailTextField.layer.masksToBounds = YES;
    self.emailTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.emailTextField.layer.borderWidth = 1.0f;
    self.emailTextField.textColor = [UIColor blackColor];
    self.emailTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.emailTextField.attributedText =
    [AttributedString bodyASWithColor:[UIColor blackColor] string:self->emailString];
    self.emailTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30] string:@"your_email@mail.com"];
    
    // add devider view to EMAIL TEXT FIELD
    UIView *emailDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.emailTextField.leftView = emailDeviderView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    // password label
    self.passwordLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Password *"];
    
    // password text field
    self.passwordTextField.delegate = self;
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.layer.cornerRadius = 4.0f;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.passwordTextField.layer.borderWidth = 1.0f;
    self.passwordTextField.textColor = [UIColor blackColor];
    self.passwordTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.passwordTextField.attributedText =
    [AttributedString bodyASWithColor:[UIColor blackColor] string:self->passwordString];
    self.passwordTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30] string:@"your password"];
    
    // add devider view to PASSWORD TEXT FIELD
    UIView *passwordDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.passwordTextField.leftView = passwordDeviderView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    // SAVE BUTTON
    self.saveButtonOutlet.backgroundColor = [ProjectColor myRedColor];
    self.saveButtonOutlet.layer.cornerRadius = self.saveButtonOutlet.frame.size.height/2 - 0.5;
    [self.saveButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Save"] forState:UIControlStateNormal];
    self.saveButtonOutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.saveButtonOutlet.layer.shadowOffset = CGSizeMake(0, 2);
    self.saveButtonOutlet.layer.shadowOpacity = 0.7;
    self.saveButtonOutlet.layer.shadowRadius = 4;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


-(void) getCountryData {
    [[[self.ref child:@"Country"] child:self->countryString] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.cityArray = [[NSMutableArray alloc] init];

        NSArray *arr = snapshot.value;
        NSMutableArray *fullArr = [[NSMutableArray alloc]init];
        for (NSString *str in arr) {
            [fullArr addObject:str];
        };
        
        NSString *string = fullArr;
        [self.cityArray addObject:string];

    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"CANCEL BLOCK %@", error.localizedDescription);
    }];
}


- (void) getUserInfo {
    NSLog(@"uid - %@", SECRET_USER_ID);
    
    [[[self.ref child:@"users"] child:SECRET_USER_ID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        [self getPhoto];
        
        NSDictionary *dict = [[NSDictionary alloc] init];
        
        dict = snapshot.value;
        NSLog(@"%@", dict);
        
        
        self->emailString = snapshot.value[@"email"];
        self->passwordString = snapshot.value[@"password"];
        
        self->firstNameString = [[snapshot.value valueForKey:@"info"] valueForKey:@"firstName"];
        self->lastNameString = [[snapshot.value valueForKey:@"info"] valueForKey:@"lastName"];
        
        self->countryString = [[snapshot.value valueForKey:@"info"] valueForKey:@"country"];
        if (!self->countryString) {
            [self.countryButtonOutlet setTitle:@"country" forState:UIControlStateNormal];
        } else {
            [self.countryButtonOutlet setTitle:self->countryString forState:UIControlStateNormal];
        }
        
        self->cityString = [[snapshot.value valueForKey:@"info"] valueForKey:@"city"];
        if (!self->cityString){
            [self.cityButtonOutlet setTitle:@"city" forState:UIControlStateNormal];
        } else {
            [self.cityButtonOutlet setTitle:self->cityString forState:UIControlStateNormal];
        }
        
        self->phoneString = [[snapshot.value valueForKey:@"info"] valueForKey:@"phone"];
        
        self->dateOfBirthString = [[snapshot.value valueForKey:@"info"] valueForKey:@"birthday"];
        if (!self->dateOfBirthString){
            [self.dateOfBirthButtonOutlet setTitle:@"birthday" forState:UIControlStateNormal];
        } else {
            [self.dateOfBirthButtonOutlet setTitle:self->dateOfBirthString forState:UIControlStateNormal];
        }
        
        [self initComponents];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"CANCEL BLOCK %@", error.localizedDescription);
    }];
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles {
    
    switch (pickerView.tag) {
        case 1: [self.countryButtonOutlet setTitle:[titles componentsJoinedByString:@" - "] forState:UIControlStateNormal];
            self->countryString = [titles objectAtIndex:0];
            [self getCountryData];
            break;
        case 2: [self.cityButtonOutlet setTitle:[titles componentsJoinedByString:@" - "] forState:UIControlStateNormal];
            self->cityString = [titles objectAtIndex:0];
            break;
            
        default:
            break;
    }
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    switch (pickerView.tag)
    {
        case 3:
        {
//            birthday = date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [self.dateOfBirthButtonOutlet setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
            self->dateOfBirthString = [formatter stringFromDate:date];
        }
            break;
        default:
            break;
    }
}

- (IBAction)countryButtonAction:(id)sender {
    self.cityButtonOutlet.enabled = YES;
    IQActionSheetPickerView *pickerCountry = [[IQActionSheetPickerView alloc] initWithTitle:@"select country" delegate:self];
    pickerCountry.titleFont = [UIFont systemFontOfSize:12];
    pickerCountry.titleColor = [UIColor redColor];
    [pickerCountry setTag:1];
    [pickerCountry setTitlesForComponents:@[@[@"Ukraine", @"Poland", @"Germani"]]];
    [pickerCountry show];
}

- (IBAction)cityButtonAction:(id)sender {
    IQActionSheetPickerView *pickerCity = [[IQActionSheetPickerView alloc] initWithTitle:@"select city" delegate:self];
    pickerCity.titleFont = [UIFont systemFontOfSize:12];
    pickerCity.titleColor = [UIColor redColor];
    [pickerCity setTag:2];
    NSLog(@"ARRAY: %@", cityArray);
    [pickerCity setTitlesForComponents:cityArray];
    [pickerCity show];
}

- (IBAction)birthdayButtonAction:(id)sender {
    IQActionSheetPickerView *pickerBirthday = [[IQActionSheetPickerView alloc] initWithTitle:@"select birthday" delegate:self];
    pickerBirthday.titleFont = [UIFont systemFontOfSize:12];
    pickerBirthday.titleColor = [UIColor redColor];
    [pickerBirthday setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [pickerBirthday setTag:3];
    [pickerBirthday show];
}

- (IBAction)takePhoto:(id)sender {
}

-(void) getPhoto {
    
    self.avatarImageView.image = [UIImage imageNamed:@"user"];
}

- (IBAction)saveButtonAction:(id)sender {

    NSLog(@"firstName %@", self.firstNameTextField.text);
    NSLog(@"lastName %@", self.lastNameTextField.text);
    NSLog(@"country %@", self->countryString);
    NSLog(@"city %@", self->cityString);
    NSLog(@"phone %@", self.phoneTextField.text);
    NSLog(@"birthday %@", self->dateOfBirthString);


    if ([self.firstNameTextField.text isEqualToString:@""] || [self.lastNameTextField.text isEqualToString:@""] || self->countryString == Nil || self->cityString == Nil || [self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text.length != 10 || self->dateOfBirthString == Nil) {
    
    } else {
//        NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
//        
//        NSDictionary *dict = @{@"firstName": self.firstNameField.text,
//                               @"lastName": self.lastNameField.text,
//                               @"country": country,
//                               @"city": city,
//                               @"phone": self.phoneField.text,
//                               @"birthday": birthString,
//                               @"image": @""
//                               };
//        NSLog(@"dict :%@", dict);
//        [[[[self.ref child:@"users"] child:uid] child:@"info"] setValue:dict];
    }
}
@end
