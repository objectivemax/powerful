//
//  LeftViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "LeftViewController.h"

@implementation LeftViewController

- (void)viewDidLoad {
    
//    MMAttributedString *attributedString = [[MMAttributedString alloc] init];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // set logo
    self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width/2;
    self.logoImageView.layer.masksToBounds = YES;
    self.logoImageView.image = [UIImage imageNamed:@"profile-user.png"];
    
//    __weak typeof(self) weakSelf = self;
//    [self.logoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://secure.managemart.com/userfiles/%@/logo/%@",COMPANY_ID, COMPANY_LOGO]]]
//                              placeholderImage:[UIImage imageNamed:@"nopic.png"]
//                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                           weakSelf.logoImageView.alpha = 0.0;
//                                           weakSelf.logoImageView.image = image;
//                                           [UIView animateWithDuration:0.25
//                                                            animations:^{
//                                                                weakSelf.logoImageView.alpha = 1.0;
//                                                            }];
//                                       }
//                                       failure:NULL];
    
    
    
    
    // set company name label
//    self.companyNameLabel.attributedText =
//    [attributedString subheadAttributedStringWithColor:[UIColor whiteColor]
//                                                string:COMPANY_NAME];
    
    // set user name label
//    self.userNameLabel.attributedText =
//    [attributedString footnoteAttributedStringWithColor:[UIColor whiteColor]
//                                                 string:[NSString stringWithFormat:@"%@ %@", FIRST_NAME, LAST_NAME]];
    self.userNameLabel.text = @"user";
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    self.menus = @[@"News", @"Sources", @"Weather", @"Users", @"Profile", @"Logout"];
    //    self.tableView.separatorColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewsViewController *newsController = (NewsViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"newsViewController"];
    self.newsViewController = [[UINavigationController alloc] initWithRootViewController: newsController];
    
    SourcesViewController *sourcesController = (SourcesViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"sourcesViewController"];
    self.sourcesViewControler = [[UINavigationController alloc] initWithRootViewController: sourcesController];
    
    WeatherViewController *weatherController = (WeatherViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"weatherViewController"];
    self.weatherViewController = [[UINavigationController alloc] initWithRootViewController: weatherController];

    UsersViewController *usersController = (UsersViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"usersViewController"];
    self.usersViewController = [[UINavigationController alloc] initWithRootViewController: usersController];

    ProfileViewController *profileController = (ProfileViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"profileViewController"];
    self.profileViewController = [[UINavigationController alloc] initWithRootViewController: profileController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //    self.imageHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 160);
    [self.view layoutIfNeeded];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menus count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"leftMenuCell";
    
    NSString *text = [self.menus objectAtIndex:indexPath.row];
    
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell setCell:text];
    
    // NOT ALLOWS SELECTION -------
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *name = [self.menus objectAtIndex:indexPath.row];
    
    if ([name isEqualToString:@"News"]){
        [self.slideMenuController changeMainViewController:self.newsViewController close:YES];
    }
    
    if ([name isEqualToString:@"Sources"]){
        [self.slideMenuController changeMainViewController:self.sourcesViewControler close:YES];
    }
    
    if ([name isEqualToString:@"Weather"]){
        [self.slideMenuController changeMainViewController:self.weatherViewController close:YES];
    }
    
    if ([name isEqualToString:@"Users"]){
        [self.slideMenuController changeMainViewController:self.usersViewController close:YES];
    }
    
    if ([name isEqualToString:@"Profile"]){
        [self.slideMenuController changeMainViewController:self.profileViewController close:YES];
    }
    
    if ([name isEqualToString:@"Logout"]){
        // delete all user defaults key
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [CommonData setUserId:nil];
        
//        // FACEBOOK LOGOUT
//        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//        [loginManager logOut];
//
//        // GOOGLE LOGOUT
//        [[GIDSignIn sharedInstance] signOut];
//
        [NAVIGATION_MANAGER setRegistration];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)sender {
//    sender.contentOffset.x = 0.0
//    sender.contentOffset.x = 0.0;
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGSize scrollview_content=scrollView.contentSize;
//    CGPoint scrollview_offset=scrollView.contentOffset;
//    CGFloat size=scrollview_content.width;
//    CGFloat x=scrollview_offset.x;
//    if ((size-self.view.frame.size.width)==x) {
//        //You have reached last page
//        NSLog(@"LAST");
//        self.tableView.scrollEnabled = NO;
//    }
//}

@end
