//
//  FirstSetupViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/15/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
@import Firebase;
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstSetupViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IQActionSheetPickerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UINavigationBar *customNavigationBar;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *registerButtonOutlet;
- (IBAction)registerButtonAction:(id)sender;

@property (strong, nonatomic) NSDictionary *jsonContryWithCity;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *dateOfBirth;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

// ------------- PHOTO + FULL NAME -------------
@property (strong, nonatomic) UITableViewCell *firstCell;

@property (strong, nonatomic) UILabel *photoLabel;
@property (strong, nonatomic) UIView *photoView;
@property (strong, nonatomic) UIImageView *photoIcon;
@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UIButton *photoButton;

@property (strong, nonatomic) UILabel *fullNameLabel;
@property (strong, nonatomic) UITextField *firstNameTextField;
@property (strong, nonatomic) UITextField *lastNameTextField;


// ------------- COUNTRY + CITY -------------
@property (strong, nonatomic) UITableViewCell *locationCell;
@property (strong, nonatomic) UILabel *countryLabel;
@property (strong, nonatomic) UIButton *countryButton;

@property (strong, nonatomic) UILabel *cityLabel;
@property (strong, nonatomic) UIButton *cityButton;


// ------------- PHONE -------------
@property (strong, nonatomic) UITableViewCell *phoneCell;

@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UITextField *phoneTextField;


// ------------- DATE OF BIRTH -------------
@property (strong, nonatomic) UITableViewCell *dateOfBirthCell;

@property (strong, nonatomic) UILabel *dateOfBirthLabel;
@property (strong, nonatomic) UIButton *dateOfBirthButton;


@end

NS_ASSUME_NONNULL_END
