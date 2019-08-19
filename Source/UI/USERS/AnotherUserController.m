//
//  AnotherUserController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/31/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "AnotherUserController.h"

@interface AnotherUserController ()

@end

@implementation AnotherUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getWeather];
}

- (void) setUserInfo {
    self.firstNameLabel.text = self.fName;
    self.lastNameLabel.text = self.lName;
    self.countryLabel.text = [NSString stringWithFormat:@"%@/%@", self.city,self.country];
    self.birthdayLabel.text = self.birthday;
    self.phoneLabel.text = self.phone;
    self.emailLabel.text = self.email;
}

- (void) getWeather {
    NSString *city = [NSString stringWithString:self.city];
    NSString *stringUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=7e5726a9a8b3270583785631c72be857", city];
    
    NSURL *weatherURL = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:weatherURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
        } else {
            
            [self setUserInfo];
        
            NSString *temperatyra = [[responseObject objectForKey:@"main"] objectForKey:@"temp"];    // ТЕМПЕРАТУРА
            double kelvin = [temperatyra doubleValue];
            NSString *humidity = [[responseObject objectForKey:@"main"] objectForKey:@"humidity"];   // ВЛАЖНОСТЬ
            NSString *speedWind = [[responseObject objectForKey:@"wind"] objectForKey:@"speed"];     // СКОРОСТЬ ВЕТРА
            
            
            NSNumber *number = [NSNumber numberWithDouble:273.15];
            if ([temperatyra isEqual:number]) {
                self.tempLabel.text = @"0°";
            } else {
                self.tempLabel.text = [NSString stringWithFormat:@"%.ld°", lroundf(kelvin - 273.15), temperatyra];
            }
            self.wetLabel.text = [NSString stringWithFormat:@"%@°" , humidity];
            self.speedLabel.text = [NSString stringWithFormat:@"%@m/s" , speedWind];
        }
    }];
    [dataTask resume];
}


@end
