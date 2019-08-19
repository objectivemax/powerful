//
//  AnotherUserController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/31/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface AnotherUserController : UIViewController

// name view
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

// weather view
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *wetLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

// phone view
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

// email view
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) NSString *fName;
@property (weak, nonatomic) NSString *lName;
@property (weak, nonatomic) NSString *country;
@property (weak, nonatomic) NSString *city;
@property (weak, nonatomic) NSString *birthday;
@property (weak, nonatomic) NSString *phone;
@property (weak, nonatomic) NSString *email;
@property (weak, nonatomic) NSString *imageSting;




@end
