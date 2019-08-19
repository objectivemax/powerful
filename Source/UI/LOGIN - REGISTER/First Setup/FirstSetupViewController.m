//
//  FirstSetupViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/15/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "FirstSetupViewController.h"

@interface FirstSetupViewController ()

@end

@implementation FirstSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    
    self.view.backgroundColor = [ProjectColor myLightBlueColor];
    
    self.tableView.backgroundColor = [ProjectColor myLightBlueColor];
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.tableView.separatorColor = [ProjectColor myMainLightPurpleColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"dd-MM-yyyy";
    
    self.dateOfBirth = @"20.04.1889";
    
    self.firstCell = [[UITableViewCell alloc] init];
    self.firstCell.backgroundColor = [UIColor clearColor];
    self.locationCell = [[UITableViewCell alloc] init];
    self.locationCell.backgroundColor = [UIColor clearColor];
    self.phoneCell = [[UITableViewCell alloc] init];
    self.phoneCell.backgroundColor = [UIColor clearColor];
    self.dateOfBirthCell = [[UITableViewCell alloc] init];
    self.dateOfBirthCell.backgroundColor = [UIColor clearColor];
    
    // REGISTER BUTTON
    self.registerButtonOutlet.backgroundColor = [ProjectColor myRedColor];
    self.registerButtonOutlet.layer.cornerRadius = self.registerButtonOutlet.frame.size.height/2 - 0.5;
    [self.registerButtonOutlet setAttributedTitle:[AttributedString bodyASWithColor:[ProjectColor myWhiteColor] string:@"Register"] forState:UIControlStateNormal];
    self.registerButtonOutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.registerButtonOutlet.layer.shadowOffset = CGSizeMake(0, 2);
    self.registerButtonOutlet.layer.shadowOpacity = 0.7;
    self.registerButtonOutlet.layer.shadowRadius = 4;
    
    [self getCountryData];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    // main title
    self.customNavigationBar.backgroundColor = [ProjectColor myLightBlueColor];
    self.customNavigationBar.topItem.title = @"Register form";
    self.customNavigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];
}


- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 1000) {
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString* newString = [textField.text stringByReplacingCharactersInRange:range
                                                                      withString:string];
        
        NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        static const int maxLength = 10;
        
        newString = [validComponents componentsJoinedByString:@""];
        
        if ([newString length] > maxLength) {
            return NO;
        }
        
        NSMutableString* resultString = [NSMutableString string];
        
        NSInteger localNumberLength = MIN([newString length], maxLength);
        if (maxLength > 0) {
            NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            [resultString appendString:number];
        }
        
        textField.text = resultString;
        return NO;
        
    } else {
        return YES;
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"KeyboardWillshow");
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.firstNameTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.firstNameTextField.frame.origin.y - (keyboardSize.height-15));
        [self.tableView setContentOffset:scrollPoint animated:YES];
        NSLog(@"Scrolled");
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}



- (void) getCountryData {
    
    [[self.ref child:@"Country"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.jsonContryWithCity = snapshot.value;
        self.country = [[self.jsonContryWithCity allKeys] firstObject];
        self.city = [[[self.jsonContryWithCity valueForKey:[[self.jsonContryWithCity allKeys] firstObject]] allKeys] firstObject];
        
        [self initAllUIElement];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"CANCEL BLOCK %@", error.localizedDescription);
    }];
    
}


- (void) initAllUIElement {
    
    // ---------------------------------------------------------------------------------
    // -------------- CELL 0 (FIRST CELL) ----------------------------------------------
    // ---------------------------------------------------------------------------------
    
    // photo view
    self.photoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (PHOTO_VIEW_SIZE/2), TOP, PHOTO_VIEW_SIZE, PHOTO_VIEW_SIZE)];
    self.photoView.backgroundColor = [[ProjectColor myBlueColor] colorWithAlphaComponent:0.24];
    self.photoView.layer.cornerRadius = self.photoView.frame.size.height/2;
    self.photoView.layer.masksToBounds = YES;
    self.photoView.layer.borderColor = [[[ProjectColor myBlueColor]colorWithAlphaComponent:0.69] CGColor];
    self.photoView.layer.borderWidth = 10.0f;
    [self.firstCell addSubview:self.photoView];
    
    //add photo icon
    self.photoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.photoView.frame.size.width/2 - ICON_SIZE/2, self.photoView.frame.size.height/2 - ICON_SIZE/2, ICON_SIZE, ICON_SIZE)];
    self.photoIcon.image = [UIImage imageNamed:@"add_photo.png"];
    [self.photoView addSubview:self.photoIcon];
    
    // photo image view
    self.photoImageView = [[UIImageView alloc] initWithFrame:self.photoView.frame];
    self.photoImageView.backgroundColor = [UIColor clearColor];
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height/2;
    self.photoImageView.layer.masksToBounds = YES;
    [self.firstCell addSubview:self.photoImageView];
    
    // photo button
    self.photoButton = [[UIButton alloc] initWithFrame:self.photoView.frame];
    self.photoButton.layer.cornerRadius = self.photoButton.frame.size.height/2;
    [self.photoButton addTarget:self action:@selector(photoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.firstCell addSubview:self.photoButton];
    
    
    
    // full name label
    self.fullNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + PHOTO_VIEW_SIZE + TOP, SCREEN_WIDTH - LEFT - RIGHT, TITLE_HEIGHT)];
    self.fullNameLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Full Name *"];
    [self.firstCell addSubview:self.fullNameLabel];
    
    // first name text field
    self.firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(LEFT, TOP + PHOTO_VIEW_SIZE + TOP + TITLE_HEIGHT, SCREEN_WIDTH - LEFT - RIGHT, TEXT_FIELD_HEIGHT)];
    self.firstNameTextField.delegate = self;
    self.firstNameTextField.backgroundColor = [UIColor clearColor];
    self.firstNameTextField.layer.cornerRadius = 4.0f;
    self.firstNameTextField.layer.masksToBounds = YES;
    self.firstNameTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.firstNameTextField.layer.borderWidth = 1.0f;
    self.firstNameTextField.textColor = [UIColor blackColor];
    self.firstNameTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.firstNameTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                               string:@"First Name"];
    // add devider view to FIRST NAME TEXT FIELD
    UIView *firstNameDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.firstNameTextField.leftView = firstNameDeviderView;
    self.firstNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.firstCell addSubview:self.firstNameTextField];

    
    // last name
    self.lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(LEFT, TOP + PHOTO_VIEW_SIZE + TOP + TITLE_HEIGHT + TEXT_FIELD_HEIGHT + TOP, SCREEN_WIDTH - LEFT - RIGHT, TEXT_FIELD_HEIGHT)];
    self.lastNameTextField.delegate = self;
    self.lastNameTextField.backgroundColor = [UIColor clearColor];
    self.lastNameTextField.layer.cornerRadius = 4.0f;
    self.lastNameTextField.layer.masksToBounds = YES;
    self.lastNameTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.lastNameTextField.layer.borderWidth = 1.0f;
    self.lastNameTextField.textColor = [UIColor blackColor];
    self.lastNameTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.lastNameTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30]
                               string:@"Last Name"];
    // add devider view to LAST NAME TEXT FIELD
    UIView *lastNameDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.lastNameTextField.leftView = lastNameDeviderView;
    self.lastNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.firstCell addSubview:self.lastNameTextField];
    
    
    // ---------------------------------------------------------------------------------
    // -------------- CELL 1 (LOCATION CELL) -------------------------------------------
    // ---------------------------------------------------------------------------------
    
    // country label
    self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP, SCREEN_WIDTH/2 - LEFT - (RIGHT/2), TITLE_HEIGHT)];
    self.countryLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Country *"];
    [self.locationCell addSubview:self.countryLabel];
    

    // city label
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + (LEFT/2), TOP, SCREEN_WIDTH/2 - (LEFT/2) - RIGHT, TITLE_HEIGHT)];
    self.cityLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"City *"];
    [self.locationCell addSubview:self.cityLabel];
    
    
    // country button
    self.countryButton = [[UIButton alloc] initWithFrame:CGRectMake(LEFT, TOP + TITLE_HEIGHT, SCREEN_WIDTH/2 - LEFT - (RIGHT/2), BUTTON_HEIGHT)];
    self.countryButton.layer.cornerRadius = self.countryButton.frame.size.height/2 - 0.5;
    self.countryButton.backgroundColor = [ProjectColor myBlueColor];
    [self.countryButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:self.country] forState:UIControlStateNormal];
    [self.countryButton addTarget:self action:@selector(countryButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.locationCell addSubview:self.countryButton];
    
    
    // city button
    self.cityButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + (LEFT/2), TOP + TITLE_HEIGHT, SCREEN_WIDTH/2 - (LEFT/2) - RIGHT, BUTTON_HEIGHT)];
    self.cityButton.layer.cornerRadius = self.cityButton.frame.size.height/2 - 0.5;
    self.cityButton.backgroundColor = [ProjectColor myBlueColor];
    [self.cityButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:self.city] forState:UIControlStateNormal];
    [self.cityButton addTarget:self action:@selector(cityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.locationCell addSubview:self.cityButton];
    
    
    // ---------------------------------------------------------------------------------
    // -------------- CELL 2 (PHONE CELL) ----------------------------------------------
    // ---------------------------------------------------------------------------------
    
    // phone label
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP, SCREEN_WIDTH - LEFT - RIGHT, TITLE_HEIGHT)];
    self.phoneLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Phone *"];
    [self.phoneCell addSubview:self.phoneLabel];
    
    // phone text field
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(LEFT, TOP + TITLE_HEIGHT, SCREEN_WIDTH - LEFT - RIGHT, TEXT_FIELD_HEIGHT)];
    self.phoneTextField.delegate = self;
    self.phoneTextField.tag = 1000;
    self.phoneTextField.backgroundColor = [UIColor clearColor];
    self.phoneTextField.layer.cornerRadius = 4.0f;
    self.phoneTextField.layer.masksToBounds = YES;
    self.phoneTextField.layer.borderColor = [[ProjectColor myBlueColor] CGColor];
    self.phoneTextField.layer.borderWidth = 1.0f;
    self.phoneTextField.textColor = [UIColor blackColor];
    self.phoneTextField.font = [UIFont fontWithName:@"MoskSemi-Bold600" size:17];
    self.phoneTextField.attributedPlaceholder =
    [AttributedString bodyASWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.30] string:@"+380901234567"];

    // add devider view to PHONE TEXT FIELD
    UIView *phoneDeviderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, TEXT_FIELD_HEIGHT)];
    self.phoneTextField.leftView = phoneDeviderView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.phoneCell addSubview:self.phoneTextField];
    
    
    
    // ---------------------------------------------------------------------------------
    // -------------- CELL 3 (DATE OF BIRTH CELL) --------------------------------------
    // ---------------------------------------------------------------------------------
    
    // date of birth label
    self.dateOfBirthLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP, SCREEN_WIDTH - LEFT - RIGHT, TITLE_HEIGHT)];
    self.dateOfBirthLabel.attributedText =
    [AttributedString subheadASWithColor:[UIColor blackColor] string:@"Date of birth *"];
    [self.dateOfBirthCell addSubview:self.dateOfBirthLabel];
    
    // date of birth button
    self.dateOfBirthButton = [[UIButton alloc] initWithFrame:CGRectMake(LEFT, TOP + TITLE_HEIGHT, SCREEN_WIDTH - LEFT - RIGHT, BUTTON_HEIGHT)];
    self.dateOfBirthButton.layer.cornerRadius = self.dateOfBirthButton.frame.size.height/2 - 0.5;
    self.dateOfBirthButton.backgroundColor = [ProjectColor myBlueColor];
    [self.dateOfBirthButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:self.dateOfBirth] forState:UIControlStateNormal];
    [self.dateOfBirthButton addTarget:self action:@selector(birthdayButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.dateOfBirthCell addSubview:self.dateOfBirthButton];
    
}



#pragma Table View Data Source

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Return the number of rows for each section in your static table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return 4;  // section 0 has 4 rows
            
        default:
            return 0;
    };
}

// Return the row for the corresponding section and row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.section)
    {
        case 0:
            switch(indexPath.row)
        {
            case 0:
                self.tableView.rowHeight = TOP + PHOTO_VIEW_SIZE + TOP + TITLE_HEIGHT + TEXT_FIELD_HEIGHT + TOP + TEXT_FIELD_HEIGHT + TOP;
                [self.firstCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return self.firstCell;  // section 0, row 0 is the photo + full name
            case 1:
                self.tableView.rowHeight = TOP + TITLE_HEIGHT + BUTTON_HEIGHT + TOP;
                [self.locationCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return self.locationCell;   // section 0, row 1 is the location
            case 2:
                self.tableView.rowHeight = TOP + TITLE_HEIGHT + TEXT_FIELD_HEIGHT + TOP;
                [self.phoneCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return self.phoneCell;   // section 0, row 2 is the phone
            case 3:
                self.tableView.rowHeight = TOP + TITLE_HEIGHT + TEXT_FIELD_HEIGHT + TOP;
                [self.dateOfBirthCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return self.dateOfBirthCell;   // section 0, row 3 is date of birth
        }
    }
    return nil;
}

- (void) photoButtonAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"Whould you like to add photo?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              NSLog(@"done");
                                                              
                                                              UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                              picker.delegate = self;
                                                              [picker setModalPresentationStyle: UIModalPresentationOverCurrentContext];
                                                              picker.allowsEditing = YES;
                                                              picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              picker.navigationBar.tintColor = [UIColor blackColor];
                                                              
                                                              
                                                              
                                                              [self presentViewController:picker animated:YES completion:nil];
                                                              
                                                          }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel");
    }];
    
    [alertController addAction:defaultAction];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        self.photoImageView.image = image;
    }];
    
    
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        switch (status) {
//            case PHAuthorizationStatusAuthorized:
//                NSLog(@"PHAuthorizationStatusAuthorized");
//                break;
//            case PHAuthorizationStatusDenied:
//                NSLog(@"PHAuthorizationStatusDenied");
//                break;
//            case PHAuthorizationStatusNotDetermined:
//                NSLog(@"PHAuthorizationStatusNotDetermined");
//                break;
//            case PHAuthorizationStatusRestricted:
//                NSLog(@"PHAuthorizationStatusRestricted");
//                break;
//        }
//    }];
    
    
    
    
//    // Get the selected image's NSURL.
//
//    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
//    NSString *imageName = [imagePath lastPathComponent];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *localFilePathString = [documentsDirectory stringByAppendingPathComponent:imageName];
//    NSURL *localFile = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",localFilePathString]];
//
//    // Create the file metadata
//    FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
//    metadata.contentType = @"image/jpeg";
//
    // Get a reference to the storage service using the default Firebase App
//    FIRStorage *storage = [FIRStorage storage];
//
    // Create a storage reference from our storage service
//    FIRStorageReference *storageRef = [storage reference];
//
//    // Upload file and metadata to the object 'images/mountains.jpg'
//    FIRStorageUploadTask *uploadTask = [storageRef putFile:localFile metadata:metadata];
//
//    // Listen for state changes, errors, and completion of the upload.
//    [uploadTask observeStatus:FIRStorageTaskStatusResume handler:^(FIRStorageTaskSnapshot *snapshot) {
//        // Upload resumed, also fires when the upload starts
//        NSLog(@"%@", snapshot);
//    }];
    
    
    
    // File located on disk
//    NSURL *localFile = [NSURL URLWithString:[info objectForKey:@"UIImagePickerControllerReferenceURL"]];
    
    // Create a reference to the file you want to upload
//    FIRStorageReference *riversRef = [storageRef child:@"images/rivers.jpg"];
//
//    // Upload the file to the path "images/rivers.jpg"
//    FIRStorageUploadTask *uploadTask = [riversRef putFile:localFile metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
//        if (error != nil) {
//            // Uh-oh, an error occurred!
//        } else {
//            // Metadata contains file metadata such as size, content-type, and download URL.
//            int size = metadata.size;
//            // You can also access to download URL after upload.
//            [riversRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
//                if (error != nil) {
//                    // Uh-oh, an error occurred!
//                } else {
//                    NSURL *downloadURL = URL;
//                }
//            }];
//        }
//    }];
    
    
    
    
    // Local file you want to upload
//    NSURL *localFile = [NSURL URLWithString:@"path/to/image"];
    
    // Create the file metadata
//    FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
//    metadata.contentType = @"image/jpeg";
//
//    // Upload file and metadata to the object 'images/mountains.jpg'
//    FIRStorageUploadTask *uploadTask = [storageRef putFile:localFile metadata:metadata];
//
//    // Listen for state changes, errors, and completion of the upload.
//    [uploadTask observeStatus:FIRStorageTaskStatusResume handler:^(FIRStorageTaskSnapshot *snapshot) {
//        // Upload resumed, also fires when the upload starts
//        NSLog(@"%@", snapshot);
//    }];
//
//    [uploadTask observeStatus:FIRStorageTaskStatusPause handler:^(FIRStorageTaskSnapshot *snapshot) {
//        // Upload paused
//    }];
//
//    [uploadTask observeStatus:FIRStorageTaskStatusProgress handler:^(FIRStorageTaskSnapshot *snapshot) {
//        // Upload reported progress
//        double percentComplete = 100.0 * (snapshot.progress.completedUnitCount) / (snapshot.progress.totalUnitCount);
//    }];
//
//    [uploadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
//        // Upload completed successfully
//    }];
//
//    // Errors only occur in the "Failure" case
//    [uploadTask observeStatus:FIRStorageTaskStatusFailure handler:^(FIRStorageTaskSnapshot *snapshot) {
//        if (snapshot.error != nil) {
//            switch (snapshot.error.code) {
//                case FIRStorageErrorCodeObjectNotFound:
//                    // File doesn't exist
//                    break;
//
//                case FIRStorageErrorCodeUnauthorized:
//                    // User doesn't have permission to access file
//                    break;
//
//                case FIRStorageErrorCodeCancelled:
//                    // User canceled the upload
//                    break;
//
//                    /* ... */
//
//                case FIRStorageErrorCodeUnknown:
//                    // Unknown error occurred, inspect the server response
//                    break;
//            }
//        }
//    }];
    
    
}







- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController.viewControllers count] == 3 && ([[[[navigationController.viewControllers objectAtIndex:2] class] description] isEqualToString:@"PUUIImageViewController"] || [[[[navigationController.viewControllers objectAtIndex:2] class] description] isEqualToString:@"PLUIImageViewController"]))
        
        [self addCircleOverlayToImagePicker:viewController];
}

-(void)addCircleOverlayToImagePicker:(UIViewController*)viewController {
    UIColor *circleColor = [UIColor clearColor];
    UIColor *maskColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    UIView *plCropOverlayCropView; //The default crop overlay view, we wan't to hide it and show our circular one
    UIView *plCropOverlayBottomBar; //On iPhone this is the bar with "cancel" and "choose" buttons, on Ipad it's an Image View with a label saying "Scale and move"
    
    //Subviews hirearchy is different in iPad/iPhone:
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        plCropOverlayCropView = [viewController.view.subviews objectAtIndex:1];
        plCropOverlayBottomBar = [[[[viewController.view subviews] objectAtIndex:1] subviews] objectAtIndex:1];
        
        //Protect against iOS changes...
        if (! [[[plCropOverlayCropView class] description] isEqualToString:@"PLCropOverlay"]){
            NSLog(@"Warning - Image Picker with circle overlay: PLCropOverlay not found");
            return;
        }
        if (! [[[plCropOverlayBottomBar class] description] isEqualToString:@"UIImageView"]){
            NSLog(@"Warning - Image Picker with circle overlay: BottomBar not found");
            return;
        }
    }
    else{
        plCropOverlayCropView = [[[viewController.view.subviews objectAtIndex:1] subviews] firstObject];
        plCropOverlayBottomBar = [[[[viewController.view subviews] objectAtIndex:1] subviews] objectAtIndex:1];
        
        //Protect against iOS changes...
        if (! [[[plCropOverlayCropView class] description] isEqualToString:@"PLCropOverlayCropView"]){
            NSLog(@"Image Picker with circle overlay: PLCropOverlayCropView not found");
            return;
        }
        if (! [[[plCropOverlayBottomBar class] description] isEqualToString:@"PLCropOverlayBottomBar"]){
            NSLog(@"Image Picker with circle overlay: PLCropOverlayBottomBar not found");
            return;
        }
    }
    
    //It seems that everything is ok, we found the CropOverlayCropView and the CropOverlayBottomBar
    
    plCropOverlayCropView.hidden = YES; //Hide default CropView
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    //Center the circleLayer frame:
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0f, screenHeight/2 - screenWidth/2, screenWidth, screenWidth)];
    circlePath.usesEvenOddFillRule = YES;
    circleLayer.path = [circlePath CGPath];
    circleLayer.fillColor = circleColor.CGColor;
    //Mask layer frame: it begins on y=0 and ends on y = plCropOverlayBottomBar.origin.y
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, screenWidth, screenHeight- plCropOverlayBottomBar.frame.size.height) cornerRadius:0];
    [maskPath appendPath:circlePath];
    maskPath.usesEvenOddFillRule = YES;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.fillColor = maskColor.CGColor;
    [viewController.view.layer addSublayer:maskLayer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        //On iPhone add an hint label on top saying "scale and move" or whatever you want
        UILabel *cropLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, screenWidth, 50)];
        [cropLabel setText:@"Scale and move"]; //You should localize it
        [cropLabel setTextAlignment:NSTextAlignmentCenter];
        [cropLabel setTextColor:[UIColor whiteColor]];
        [viewController.view addSubview:cropLabel];
    }
    else{ //On iPad re-add the overlayBottomBar with the label "scale and move" because we set its parent to hidden (it's a subview of PLCropOverlay)
        [viewController.view addSubview:plCropOverlayBottomBar];
    }
}


- (void)birthdayButtonAction {
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date of birth" delegate:self];
    picker.backgroundColor = [ProjectColor myLightBlueColor];
    [picker setTag:1];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
}

- (void) countryButtonAction {
    IQActionSheetPickerView *pickerCountry = [[IQActionSheetPickerView alloc] initWithTitle:@"select country" delegate:self];
    pickerCountry.titleFont = [UIFont systemFontOfSize:12];
    pickerCountry.titleColor = [UIColor redColor];
    [pickerCountry setTag:1];
    [pickerCountry setTitlesForComponents:@[[self.jsonContryWithCity allKeys]]];
    [pickerCountry show];
}

- (void) cityButtonAction {
    NSDictionary *cityDict = [self.jsonContryWithCity valueForKey:self.country];
    
    
    IQActionSheetPickerView *pickerCity = [[IQActionSheetPickerView alloc] initWithTitle:@"select city" delegate:self];
    pickerCity.titleFont = [UIFont systemFontOfSize:12];
    pickerCity.titleColor = [UIColor redColor];
    [pickerCity setTag:2];
    NSLog(@"ARRAY: %@", cityDict);
    [pickerCity setTitlesForComponents:@[[cityDict allKeys]]];
    [pickerCity show];
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    switch (pickerView.tag)
    {
        case 1:
        {
            [self.dateOfBirthButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:[self.dateFormatter stringFromDate:date]] forState:UIControlStateNormal];
            NSLog(@"%@", [self.dateFormatter stringFromDate:date]);
            self.dateOfBirth = [self.dateFormatter stringFromDate:date];
        }
            break;
            
        default:
            break;
    }
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles {
    
    switch (pickerView.tag) {
            
        case 1:
            [self.countryButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:[titles objectAtIndex:0]] forState:UIControlStateNormal];
            self.country = [titles objectAtIndex:0];
            
            // change city button title
            [self changeCityButtonTitle];
            
            break;
            
        case 2:
            [self.cityButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:[titles objectAtIndex:0]] forState:UIControlStateNormal];
            self.city = [titles objectAtIndex:0];
            break;
            
        default:
            break;
    }
}

- (void) changeCityButtonTitle {
    NSDictionary *cityDict = [self.jsonContryWithCity valueForKey:self.country];
    [self.cityButton setAttributedTitle:[AttributedString bodyASWithColor:[UIColor blackColor] string:[[cityDict allKeys] firstObject]] forState:UIControlStateNormal];
}

- (IBAction)registerButtonAction:(id)sender {
    
    if (![self.firstNameTextField.text isEqualToString:@""] && ![self.lastNameTextField.text isEqualToString:@""] && ![self.phoneTextField.text isEqualToString:@""]) {
    
        NSLog(@"\nFISRT NAME: %@\nLAST NAME: %@\nCOUNTRY: %@\nCITY: %@\nPHONE: %@\nDATE OF BIRTH: %@", self.firstNameTextField.text, self.lastNameTextField.text, self.country, self.city, self.phoneTextField.text, self.dateOfBirth);
        
        
        NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"temp_uid"];
        NSString *uemail = [[NSUserDefaults standardUserDefaults] objectForKey:@"temp_uemail"];
        NSString *upass = [[NSUserDefaults standardUserDefaults] objectForKey:@"temp_upass"];
        
        // CHANGE FIRST SETUP
        NSDictionary *dict_first_setup = @{@"email": uemail,
                                           @"password": upass,
                                           @"first_setup": @"1"};
        [[[self.ref child:@"users"] child:uid] setValue:dict_first_setup];
        NSLog(@"dict first setup :%@", dict_first_setup);
        
        // SAVE CONTACT INFORMATION
        NSDictionary *dict = @{@"firstName": self.firstNameTextField.text,
                               @"lastName": self.lastNameTextField.text,
                               @"country": self.country,
                               @"city": self.city,
                               @"phone": self.phoneTextField.text,
                               @"birthday": self.dateOfBirth,
                               @"image": @""};
        NSLog(@"dict :%@", dict);
        [[[[self.ref child:@"users"] child:uid] child:@"info"] setValue:dict];
        
        // save UID
        [CommonData setUserId:uid];
        NSLog(@"UID: %@", SECRET_USER_ID);

        [NAVIGATION_MANAGER openMainAppInitialization];        
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"Please enter valid your information."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
@end
