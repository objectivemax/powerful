//
//  NewsViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "NewsViewController.h"

#define ApiKeyString @"26c366cc0e174802bd368ece7bddd3d0"
#define UrlString @"https://newsapi.org/v2/top-headlines"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataParser = [[DataParser alloc] init];
    
    // ADMOB -------
    self.bannerView.adUnitID = @"ca-app-pub-8247492272574388/6107304081";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [self.bannerView loadRequest:request];

    // Initialization FIREBASE DATABASE -------
    self.ref = [[FIRDatabase database]reference];
    
    // Initialization Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    
    self.tableView.backgroundColor = [ProjectColor myLightBlueColor];
    
    [self getNews];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarItem];
    
    [self initNavigationBarMenu];
    
    [self checkNewSubscribed];
}

- (void) checkNewSubscribed {
    NSArray *newSubscribeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Subscribed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![newSubscribeArray isEqualToArray:self.subscribedArray]) {
        self.subscribedArray = newSubscribeArray;
        [self getNews];
        NSLog(@"view will appear");
    }
}

- (void) initNavigationBarMenu {
    
    // Navigation Title
    self.navigationItem.title = @"Fresh News";
    self.navigationController.navigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];
    
    
    // FILTER
    UIImage *filterImage = [[UIImage imageNamed:@"settings.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setImage:filterImage forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    filterButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *filterBarButton = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    
    self.navigationItem.rightBarButtonItem = filterBarButton;
}


- (void)handleRefresh:(UIRefreshControl *)refreshControl {
    
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"DONE");
        
        [self getNews];

        [self.tableView reloadData];
        [refreshControl endRefreshing];
    });
}


- (void) getNews {
    
    self.subscribedArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Subscribed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (self.subscribedArray.count == 0) {
        self.subscribedArray = @[@"bbc-news",@"the-next-web",@"the-verge"];
        [[NSUserDefaults standardUserDefaults] setValue:self.subscribedArray forKey:@"Subscribed"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.subYES = [[NSMutableString alloc] init];
    for (NSString *source in self.subscribedArray) {
        [self.subYES appendString:[NSString stringWithFormat:@"%@,",source]];
    }
    
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@?sources=%@&apiKey=%@", UrlString, self.subYES, ApiKeyString];
    NSString *encoded = [stringUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *newsURL = [NSURL URLWithString:encoded];
    NSURLRequest *request = [NSURLRequest requestWithURL:newsURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            self.jsonNews = [self->dataParser parseNews:responseObject];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                NSLog(@"otpavivli update table");
            });
        }
    }];

    [dataTask resume];

    NSLog(@"is subsribe? - %@", self.subYES);
}

#pragma mark TABLE VIEW DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"JSON WALL COUNT: %lu", (unsigned long)self.jsonNews.count);

    if (self.jsonNews){
        self.tableView.scrollEnabled = YES;
        return [self.jsonNews count];
    } else {
        self.tableView.scrollEnabled = NO;
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model;
    if (self.jsonNews) {
        model = [self.jsonNews objectAtIndex:indexPath.row];
    }
    
    NewsCell *newCell = [tableView dequeueReusableCellWithIdentifier:@"newCell"];
    if (!newCell) {
        newCell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newCell"];
    }
    
    NewsSkeletonCell *skeletonCell = [tableView dequeueReusableCellWithIdentifier:@"newSkeletonCell"];
    if (!skeletonCell) {
        skeletonCell = [[NewsSkeletonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newSkeletonCell"];
    }
    
    if (self.jsonNews) {
        [newCell setCell:model];
//        newCell.backgroundColor = [UIColor clearColor];
    } else {
        [skeletonCell setCell];
//        skeletonCell.backgroundColor = [UIColor clearColor];
    }
    
    // NOT ALLOWS SELECTION -------
    [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [skeletonCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.jsonNews) {
        return newCell;
    } else {
        return skeletonCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model;
    if (self.jsonNews) {
        model = [self.jsonNews objectAtIndex:indexPath.row];
    }
    
    NewsCell *newCell = [tableView dequeueReusableCellWithIdentifier:@"newCell"];
    if (!newCell) {
        newCell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newCell"];
    }
    
    NewsSkeletonCell *skeletonCell = [tableView dequeueReusableCellWithIdentifier:@"newSkeletonCell"];
    if (!skeletonCell) {
        skeletonCell = [[NewsSkeletonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newSkeletonCell"];
    }
    
    if (self.jsonNews) {
        [newCell setCell:model];
//        newCell.backgroundColor = [UIColor clearColor];
    } else {
        [skeletonCell setCell];
//        skeletonCell.backgroundColor = [UIColor clearColor];
    }
    
    // NOT ALLOWS SELECTION -------
    [newCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [skeletonCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.jsonNews) {
        return [self calculateHeightForConfiguredSizingCell:newCell];
    } else {
        return 320;
    }
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(NewsCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.fullSizeContentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.jsonNews){
        WebViewController *vc = [[WebViewController alloc] init];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        vc = (WebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
        NSDictionary *dict = [self.jsonNews objectAtIndex:indexPath.row];
        vc.urlPage = [dict valueForKey:@"urlInfo"];
        vc.sourceName = [dict valueForKey:@"sourceName"];
        NSLog(@"send data to next VC");
        
        [[self navigationController] pushViewController:vc animated:YES];
    }
}


- (void)filterAction {
    NewsFilterViewController *vc = [[NewsFilterViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    vc = (NewsFilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"newsFilterViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
