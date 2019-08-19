//
//  WeatherViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "WeatherViewController.h"

#define STATUS_BAR_HEIGHT           [UIApplication sharedApplication].statusBarFrame.size.height
#define NAVIGATION_BAR_HEIGHT       self.navigationController.navigationBar.frame.size.height

#define    SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define    SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height

#define LEFT 16
#define RIGHT 16
#define TOP 10
#define BIG_TOP 40

#define LABEL_HEIGHT 22

@interface WeatherViewController ()

@end

@implementation WeatherViewController {
    GMSPlacesClient *placesClient;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Navigation Title
    self.navigationItem.title = @"Weather";
    self.navigationController.navigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];
    
    [self initView];
    [self getDataClick];
    
    self.mainView.backgroundColor = [ProjectColor myLightBlueColor];
//    self.ref = [[FIRDatabase database]reference];
//    [self getCountry];
//    
//    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    [locationManager requestAlwaysAuthorization];
//    [locationManager startUpdatingLocation];
//    self.googleMapView.myLocationEnabled = YES;
//    placesClient = [GMSPlacesClient sharedClient];
//    
//    [placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
//        if (error != nil) {
//            return;
//        }
//        
//        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
//            GMSPlace* place = likelihood.place;
//        }
//    }];
//    [self currentPosition];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarItem];
}

- (void) initView {
    
    // header view
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    [self.mainView addSubview:self.headerView];
    
    // city and country label
    self.cityWithCountryLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP, SCREEN_WIDTH - LEFT - RIGHT, LABEL_HEIGHT)];
    self.cityWithCountryLabel.textAlignment = NSTextAlignmentCenter;
    self.cityWithCountryLabel.attributedText = [AttributedString bodyASWithColor:[UIColor blackColor] string:@"Kyiv, Ukraine"];
    [self.headerView addSubview:self.cityWithCountryLabel];
    
    // weather icon
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)/2, TOP + LABEL_HEIGHT + BIG_TOP, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    self.iconImageView.image = [UIImage imageNamed:@"main.png"];
    [self.headerView addSubview:self.iconImageView];
    
    // weather status label
    self.weatherStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + LABEL_HEIGHT + BIG_TOP + SCREEN_WIDTH/2, SCREEN_WIDTH - LEFT - RIGHT, LABEL_HEIGHT)];
    self.weatherStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.weatherStatusLabel.attributedText = [AttributedString bodyASWithColor:[UIColor blackColor] string:@"updating..."];
    [self.headerView addSubview:self.weatherStatusLabel];
    
    // weather temperature label
    self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + LABEL_HEIGHT + BIG_TOP + SCREEN_WIDTH/2 + LABEL_HEIGHT, SCREEN_WIDTH - LEFT - RIGHT, 80)];
    self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:@"42°"
     attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskSemi-Bold600" size:80],
                   NSForegroundColorAttributeName : [UIColor blackColor],
                   NSKernAttributeName : @(-0.24f) }];
    
    self.temperatureLabel.attributedText = attributedString;
    [self.headerView addSubview:self.temperatureLabel];
    
    
    // COLLECTION VIEW
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 80); //width and height
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height, SCREEN_WIDTH, 80) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[WeatherCollectionCell class]
            forCellWithReuseIdentifier:@"collectionCell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:self.collectionView];
    

//
//    self.rectLayer = [self drawTriangle];
//    [self.headerView.layer addSublayer:self.rectLayer];
////    NSLog(@"%@", self.rectLayer);
//    NSLog(@"this is a layer: %@", self.rectLayer.path);
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 300)];
//    imageView.image = [UIImage imageNamed:@"user1.png"];
//    imageView.layer.mask = self.rectLayer;
////    imageView. = self.rectLayer.path;
////    [self.headerView.layer addSublayer:imageView.layer];
//
//
////    UIGraphicsBeginImageContext(self.headerView.bounds.size);
////    [self.headerView.layer renderInContext:UIGraphicsGetCurrentContext()];
////    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
//    [self.headerView addSubview:imageView];
//
//
}

//-(CAShapeLayer*)drawTriangle{
//    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
//    UIBezierPath* path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width, 0)];
//    [path addLineToPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width, 200)];
//    [path addLineToPoint:CGPointMake(0, 100)];
//    [path closePath];
//
//    shapeLayer.path = [path CGPath];
////    shapeLayer.strokeColor = [[UIColor yellowColor] CGColor];
//    shapeLayer.fillColor = [[UIColor redColor] CGColor];
//    shapeLayer.lineWidth = 2.0;
//
//    return shapeLayer;
//}


//- (void) getCountry {
//    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
//    NSLog(@"uid - %@", uid);
//
//    [[[self.ref child:@"users"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//
//        self.country = [[snapshot.value valueForKey:@"info"] valueForKey:@"country"];
//        self.locationCity = [[snapshot.value valueForKey:@"info"] valueForKey:@"city"];
//        [self getDataClick];
//
//    } withCancelBlock:^(NSError * _Nonnull error) {
//        NSLog(@"CANCEL BLOCK %@", error.localizedDescription);
//    }];
//}
//
- (void) getDataClick {

    NSString *stringUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=7e5726a9a8b3270583785631c72be857", @"Kyiv"];

    NSURL *weatherURL = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:weatherURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {

             NSLog(@"Error: %@", error);
        } else {
            
            self.jsonType = @[@{@"sunrise":[[responseObject objectForKey:@"sys"] objectForKey:@"sunrise"],
                                @"type":@"sunrise"},
                              @{@"sunset":[[responseObject objectForKey:@"sys"] objectForKey:@"sunset"],
                                @"type":@"sunset"},
                              @{@"wind":[[responseObject objectForKey:@"wind"] objectForKey:@"speed"],
                                @"type":@"wind"},
                              @{@"humidity":[[responseObject objectForKey:@"main"] objectForKey:@"humidity"],
                                @"type":@"humidity"}];

//            NSString *city = [responseObject objectForKey:@"name"];                              // ГОРОД
//            NSString *temperatyra = [[responseObject objectForKey:@"main"] objectForKey:@"temp"];    // ТЕМПЕРАТУРА
//            double kelvin = [temperatyra doubleValue];
//            NSString *humidity = [[responseObject objectForKey:@"main"] objectForKey:@"humidity"];   // ВЛАЖНОСТЬ
//            NSString *speedWind = [[responseObject objectForKey:@"wind"] objectForKey:@"speed"];     // СКОРОСТЬ ВЕТРА
//
//
//            self.cityNameLabel.text = [NSString stringWithFormat:@"%@, %@",city, self.country];
//
//            NSNumber *number = [NSNumber numberWithDouble:273.15];
//            if ([temperatyra isEqual:number]) {
//                self.tempLabel.text = @"0°";
//            } else {
//            self.tempLabel.text = [NSString stringWithFormat:@"%.ld°", lroundf(kelvin - 273.15), temperatyra];
//            }
//            self.cityWetLabel.text = [NSString stringWithFormat:@"humidity: %@°" , humidity];
//            self.cityWindSpeedLabel.text = [NSString stringWithFormat:@"speed wind: %@m/s" , speedWind];
            
            
            // UPDATE ICON
            NSString *iconName = [[[responseObject objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"icon"];
            self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",iconName]];
            // ADD A LITTLE BIT ANIMATION)))
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            [self.iconImageView.layer addAnimation:transition forKey:nil];
            
            
            // UPDATE WEATER STATUS
            self.weatherStatusLabel.attributedText = [AttributedString bodyASWithColor:[UIColor blackColor] string:[[[responseObject objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"]];
            
            
            // UPDATE WEATHER TEMPERATURE
            NSString *temperatyra = [[responseObject objectForKey:@"main"] objectForKey:@"temp"];
            double kelvin = [temperatyra doubleValue];
            NSNumber *number = [NSNumber numberWithDouble:273.15];
            
            if ([temperatyra isEqual:number]) {
                NSAttributedString *attributedString =
                [[NSAttributedString alloc]
                 initWithString:@"0°"
                 attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskSemi-Bold600" size:80],
                               NSForegroundColorAttributeName : [UIColor blackColor],
                               NSKernAttributeName : @(-0.24f) }];
                
                self.temperatureLabel.attributedText = attributedString;
            } else {
                NSAttributedString *attributedString =
                [[NSAttributedString alloc]
                 initWithString:[NSString stringWithFormat:@"%.ld°", lroundf(kelvin - 273.15), temperatyra]
                 attributes: @{NSFontAttributeName : [UIFont fontWithName:@"MoskSemi-Bold600" size:80],
                               NSForegroundColorAttributeName : [UIColor blackColor],
                               NSKernAttributeName : @(-0.24f) }];
                
                self.temperatureLabel.attributedText = attributedString;
            }
            
            
            [self.collectionView reloadData];
            
        }
    }];
    [dataTask resume];
}
//
//- (void) currentPosition {
//    [locationManager startUpdatingLocation];
//    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self->locationManager.location.coordinate.latitude, self->locationManager.location.coordinate.longitude];
//    float longitude1 = locationManager.location.coordinate.longitude;
//    float latitude1 = locationManager.location.coordinate.latitude;
//
//    GMSCameraPosition *sydney = [GMSCameraPosition cameraWithLatitude: latitude1
//                                                            longitude: longitude1
//                                                                 zoom:14];
//    [self.googleMapView setCamera:sydney];
//}




#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.jsonType count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"collectionCell";
    
    NSArray *model = [self.jsonType objectAtIndex:indexPath.row];
    
    WeatherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    if (self.jsonType){
        [cell setCell:model];
    }

//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

//    NSArray *model = [self.patientArray objectAtIndex:indexPath.row];
//
//    NSString *stringName = [NSString stringWithFormat:@"%@ %@",[model valueForKey:@"patient_fname"], [model valueForKey:@"patient_lname"]];
//
//    CGFloat nameWidth = [self widthOfString:stringName withFont:[UIFont fontWithName:@"Dosis-SemiBold" size:20]];
//
//    NSLog(@"width: %f", nameWidth);

//    return CGSizeMake(nameWidth + 59, 40);
//    return CGSizeMake(200, 100);
//}

//- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
//    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
//    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    clickedItem = indexPath.row;
//
//
//    NSLog(@"%ld",(long)indexPath.row);
//
//    NSData *storageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"patient_chart_list"];
//    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:storageData];
//    arr = [[arr reverseObjectEnumerator] allObjects];
//    //    self.patientID = [[arr objectAtIndex:0] valueForKey:@"patient_id"];
//    NSLog(@"click: %@", [[arr objectAtIndex:indexPath.row]valueForKey:@"patient_fname"]);
//
//    [summarySwitch reloadTableView:[[arr objectAtIndex:indexPath.row]valueForKey:@"patient_id"]];
//    [self.collectionView reloadData];
//
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0; // This is the minimum inter item spacing, can be more
//}


//- (void) didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self.collectionView performBatchUpdates:^ {
//        //        NSLog(@"index path: %ld", (long)indexPath.row);
//        //
//        //        NSLog(@"before array count: %lu", (unsigned long)[self.patientArray count]);
//        
//        [self.patientArray removeObjectAtIndex:indexPath.row];
//        
//        NSData *storedData = [NSKeyedArchiver archivedDataWithRootObject:self.patientArray];
//        [[NSUserDefaults standardUserDefaults] setValue:storedData forKey:@"patient_chart_list"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        
//        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]]; // no assertion now
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//        
//        if (self->clickedItem == 0){
//            self->clickedItem = 0;
//        } else {
//            self->clickedItem = self->clickedItem - 1;
//        }
//        
//        [self.collectionView reloadData];
//        
//        if ([self.patientArray count] == 0){
//            [self personAddButtonAction];
//        }
//        
//    } completion:nil ];
//}


@end
