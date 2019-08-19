//
//  WeatherViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
@import Firebase;
@import GooglePlaces;
#import "QuartzCore/QuartzCore.h"
#import "WeatherCollectionCell.h"
#import "ProjectColor.h"

@interface WeatherViewController : UIViewController <CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) UICollectionView *collectionView;

//@property (nonatomic,retain) CLLocationManager *locationManager;
//@property (weak, nonatomic) IBOutlet GMSMapView *googleMapView;
//
//@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
//@property (weak, nonatomic) IBOutlet UILabel *cityWetLabel;
//@property (weak, nonatomic) IBOutlet UILabel *cityWindSpeedLabel;


//@property (nonatomic, retain) CAShapeLayer* shaperLayer;
//@property (nonatomic, retain) CAShapeLayer* rectLayer;


@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *cityWithCountryLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *weatherStatusLabel;
@property (strong, nonatomic) UILabel *temperatureLabel;

@property (strong, nonatomic) NSArray *jsonType;




//@property (strong, nonatomic) NSString *locationCity;
//@property (strong, nonatomic) NSString *country;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;

@end
