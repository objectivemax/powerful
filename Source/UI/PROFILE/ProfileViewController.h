//
//  ProfileViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
@import Firebase;

@interface ProfileViewController : UIViewController <UIAlertViewDelegate, IQActionSheetPickerViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (strong, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) IBOutlet UIButton *countryButtonOutlet;

@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIButton *cityButtonOutlet;

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;

@property (strong, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (strong, nonatomic) IBOutlet UIButton *dateOfBirthButtonOutlet;

@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *saveButtonOutlet;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;

@property (strong, nonnull) NSMutableArray *cityArray;

- (IBAction)countryButtonAction:(id)sender;
- (IBAction)takePhotoAction:(id)sender;
- (IBAction)cityButtonAction:(id)sender;
- (IBAction)birthdayButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;





@end
