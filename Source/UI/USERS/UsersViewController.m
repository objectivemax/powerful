//
//  UsersViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "UsersViewController.h"

@interface UsersViewController ()

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database]reference];
    dataParser = [[DataParser alloc] init];
    
    // Navigation Title
    self.navigationItem.title = @"All Users";
    self.navigationController.navigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];
    
    [self getUsersInfo];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarItem];
}


- (void) getUsersInfo {
    NSLog(@"uid - %@", SECRET_USER_ID);

    [[self.ref child:@"users"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSArray *jsonU = snapshot.value;
        self.jsonUsers = [[NSMutableArray alloc] init];
        
        for (NSString *str in jsonU){
           
            NSString *email = snapshot.value[str][@"email"];
            if (!email){
                email = @"";
            }
            
            NSString *password = snapshot.value[str][@"password"];
            if (!password){
                password = @"";
            }
            
            NSString *birthday = snapshot.value[str][@"info"][@"birthday"];
            if (!birthday) {
                birthday = @"";
            }
            
            NSString *city = snapshot.value[str][@"info"][@"city"];
            if (!city) {
                city = @"";
            }
            
            NSString *country = snapshot.value[str][@"info"][@"country"];
            if (!country) {
                country = @"";
            }
            
            NSString *firstName = snapshot.value[str][@"info"][@"firstName"];
            if (!firstName){
                firstName = @"";
            }
            
            NSString *lastName = snapshot.value[str][@"info"][@"lastName"];
            if (!lastName){
                lastName = @"";
            }
            
            NSString *phone = snapshot.value[str][@"info"][@"phone"];
            if (!phone) {
                phone = @"";
            }
            
            NSString *image = snapshot.value[str][@"info"][@"image"];
            if (!image) {
                image = @"";
            }
            
            NSDictionary *dict = @{@"uid": str,
                                   @"email": email,
                                   @"password": password,
                                   @"birthday": birthday,
                                   @"city": city,
                                   @"country": country,
                                   @"firstName": firstName,
                                   @"lastName": lastName,
                                   @"phone": phone,
                                   @"image": image
                                   };
            
            [self.jsonUsers addObject:dict];
        }
        NSLog(@"FULL JSON USERS :%@",self.jsonUsers);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            NSLog(@"otpavivli update table");
        });

    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"CANCEL BLOCK %@", error.localizedDescription);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"JSON USER COUNT: %lu", (unsigned long)self.jsonUsers.count);
    return [self.jsonUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *userIdentifier = @"userIdentifier";
    
    UsersModel *model = [self.jsonUsers objectAtIndex:indexPath.row];
    
    UsersCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UsersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userIdentifier];
    }
    [cell setCell:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_BIG;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    AnotherUserController *vc = [[AnotherUserController alloc] init];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    vc = (AnotherUserController *)[storyboard instantiateViewControllerWithIdentifier:@"anotherUserController"];
//    NSDictionary *dict = [self.jsonUsers objectAtIndex:indexPath.row];
//    
//    vc.fName = [dict valueForKey:@"firstName"];
//    vc.lName = [dict valueForKey:@"lastName"];
//    vc.country = [dict valueForKey:@"country"];
//    vc.city = [dict valueForKey:@"city"];
//    vc.imageSting = [dict valueForKey:@"image"];
//    
//    vc.birthday = [dict valueForKey:@"birthday"];
//    vc.phone = [dict valueForKey:@"phone"];
//    vc.email = [dict valueForKey:@"email"];
//    NSLog(@"send data to next VC");
//
//    [[self navigationController] pushViewController:vc animated:YES];
//}

@end
