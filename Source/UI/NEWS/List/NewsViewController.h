//
//  NewsViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuController.h"
#import "AFNetworking.h"
#import "DataParser.h"
#import "NewsCell.h"
#import "NewsSkeletonCell.h"
#import "NewsFilterViewController.h"
#import "WebViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "ProjectColor.h"
@import Firebase;
@import GoogleMobileAds;

@class GADBannerView;


@interface NewsViewController : UIViewController <SlideMenuControllerDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    DataParser *dataParser;
    UIWebView *webview;
}

@property(nonatomic, weak) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *subscribedArray;
@property (strong, nonatomic) NSArray *jsonNews;
- (IBAction)filterActionButton:(id)sender;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;
@property (strong, nonatomic) NSMutableString *subYES;
@end
