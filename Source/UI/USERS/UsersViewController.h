//
//  UsersViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnotherUserController.h"
#import "UsersModel.h"
#import "UsersCell.h"
#import "DataParser.h"
#import "AFNetworking.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
@import Firebase;

@interface UsersViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    DataParser *dataParser;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *jsonUsers;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRAuth *handle;
@end
