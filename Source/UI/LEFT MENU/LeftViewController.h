//
//  LeftViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeftMenuCell.h"
#import "NewsViewController.h"
#import "SourcesViewController.h"
#import "WeatherViewController.h"
#import "UsersViewController.h"
#import "ProfileViewController.h"


@protocol LeftMenuProtocol <NSObject>

@end

@interface LeftViewController : UIViewController<LeftMenuProtocol, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@property (retain, nonatomic) NSArray *menus;
@property (retain, nonatomic) UIViewController *newsViewController;
@property (retain, nonatomic) UIViewController *sourcesViewControler;
@property (retain, nonatomic) UIViewController *weatherViewController;
@property (retain, nonatomic) UIViewController *usersViewController;
@property (retain, nonatomic) UIViewController *profileViewController;

@end

