//
//  SourcesViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "SourcesViewController.h"

#define ApiKeyString @"26c366cc0e174802bd368ece7bddd3d0"
#define UrlString @"https://newsapi.org/v2/sources?apiKey="

@interface SourcesViewController ()

@end

@implementation SourcesViewController {
    NSArray *arrayWithoutDuplicates;
    
    NSMutableArray *generalArr;
    NSMutableArray *businessArr;
    NSMutableArray *technologyArr;
    NSMutableArray *sportsArr;
    NSMutableArray *entertainmentArr;
    NSMutableArray *scienceArr;
    NSMutableArray *healthArr;
    
    
    NSInteger generalSection;
    NSInteger businessSection;
    NSInteger technologySection;
    NSInteger sportsSection;
    NSInteger entertainmentSection;
    NSInteger scienceSection;
    NSInteger healthSection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialization Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    
    [self getSources];
    
    // Navigation Title
    self.navigationItem.title = @"Sources";
    self.navigationController.navigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];
    
    self.tableView.backgroundColor = [ProjectColor myLightBlueColor];
    
    dataParser = [[DataParser alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarItem];
}

- (void)handleRefresh:(UIRefreshControl *)refreshControl {
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"DONE");
        
        [self getSources];
        
        [self.tableView reloadData];
        [refreshControl endRefreshing];
    });
}


- (void) getSources {
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@", UrlString, ApiKeyString];
    NSString *encoded = [stringUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *newsURL = [NSURL URLWithString:encoded];
    NSURLRequest *request = [NSURLRequest requestWithURL:newsURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            self.jsonSources = [[[self->dataParser parseSource:responseObject] reverseObjectEnumerator] allObjects];
            NSLog(@"SOURCE JSON: %@", self.jsonSources);
            
            
            
            self->generalArr = [[NSMutableArray alloc] init];
            self->businessArr = [[NSMutableArray alloc] init];
            self->technologyArr = [[NSMutableArray alloc] init];
            self->sportsArr = [[NSMutableArray alloc] init];
            self->entertainmentArr = [[NSMutableArray alloc] init];
            self->scienceArr = [[NSMutableArray alloc] init];
            self->healthArr = [[NSMutableArray alloc] init];
            
            NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
            for (NSString *category in [self.jsonSources valueForKey:@"sourceCategory"]) {
                [categoryArray addObject:category];
            }
            
            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:categoryArray];
            self->arrayWithoutDuplicates = [orderedSet array];
            
            NSLog(@"category list: %@",self->arrayWithoutDuplicates);
            
            for (NSArray *arr in self.jsonSources) {
                
                if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"general"]) {
                    [self->generalArr addObject:arr];
                } else if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"business"]) {
                    [self->businessArr addObject:arr];
                } else if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"technology"]){
                    [self->technologyArr addObject:arr];
                } else if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"sports"]){
                    [self->sportsArr addObject:arr];
                } else if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"entertainment"]){
                    [self->entertainmentArr addObject:arr];
                } else if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"science"]){
                    [self->scienceArr addObject:arr];
                } else if ([[arr valueForKey:@"sourceCategory"] isEqualToString:@"health"]){
                    [self->healthArr addObject:arr];
                }
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                NSLog(@"otpavivli update table");
            });
        }
    }];
    [dataTask resume];
}

#pragma mark TABLE VIEW DELEGATE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self->arrayWithoutDuplicates count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [self->arrayWithoutDuplicates objectAtIndex:section];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 38)];
    headerView.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f];
    
    // label
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, 14, 400 - LEFT - RIGHT, 15)];
    textLabel.attributedText = [AttributedString footnoteASWithColor:[UIColor grayColor] string:[self->arrayWithoutDuplicates objectAtIndex:section]];
    [headerView addSubview:textLabel];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"JSON SOURCES COUNT: %lu", (unsigned long)self.jsonSources.count);
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"sourceIdentifier";

    SourceCell *cell = (SourceCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(SourceCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"section %ld", (long)indexPath.section);
    NSLog(@"row %ld", (long)indexPath.row);
    
    

    
    
    
    
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
//    self->index = indexPath.section;
    
    CGFloat horizontalOffset;
    
    if (indexPath.section == 0) {
        self->generalSection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->generalSection) stringValue]] floatValue];
        
    } else if (indexPath.section == 1) {
        self->businessSection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->businessSection) stringValue]] floatValue];
        
    } else if (indexPath.section == 2) {
        self->technologySection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->technologySection) stringValue]] floatValue];
        
    } else if (indexPath.section == 3) {
        self->sportsSection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->sportsSection) stringValue]] floatValue];
        
    } else if (indexPath.section == 4) {
        self->entertainmentSection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->entertainmentSection) stringValue]] floatValue];
        
    } else if (indexPath.section == 5) {
        self->scienceSection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->scienceSection) stringValue]] floatValue];
        
    } else {
        self->healthSection = indexPath.section;
        horizontalOffset = [self.contentOffsetDictionary[[@(self->healthSection) stringValue]] floatValue];
    }
    
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    
//    NSLog(@"index = %ld", (long)self->index);
//
//    NSDictionary *dict = self->arrayWithoutDuplicates;
//
//    CGFloat horizontalOffset = [self->arrayWithoutDuplicates[[@(self->index) stringValue]] floatValue];
//    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    
//    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(self->index) stringValue]] floatValue];
//    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    WebViewController *vc = [[WebViewController alloc] init];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    vc = (WebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
//    NSDictionary *dict = [self.jsonSources objectAtIndex:indexPath.row];
//    vc.urlPage = [dict valueForKey:@"sourceURL"];
//    NSLog(@"send data to next VC");
//    
//    [[self navigationController] pushViewController:vc animated:YES];
//}

#pragma mark - UICollectionViewDataSource Methods

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger sectionNumber = [(AFIndexedCollectionView *)collectionView indexPath].section;
    
    NSLog(@"section:%ld", (long)sectionNumber);
    
    if (self->generalSection == sectionNumber) {
        return [self->generalArr count];
        
    } else if (self->businessSection == sectionNumber) {
        return[self->businessArr count];
        
    } else if (self->technologySection == sectionNumber) {
        return[self->technologyArr count];
        
    } else if (self->sportsSection == sectionNumber) {
        return[self->sportsArr count];
        
    } else if (self->entertainmentSection == sectionNumber) {
        return[self->entertainmentArr count];
        
    } else if (self->scienceSection == sectionNumber) {
        return[self->scienceArr count];
        
    } else {
        return[self->healthArr count];
    }

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger sectionNumber = [(AFIndexedCollectionView *)collectionView indexPath].section;
    NSArray *model;

    SourceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SourceCellIdentifier" forIndexPath:indexPath];

    
    if (self->generalSection == sectionNumber) {
        model = [self->generalArr objectAtIndex:indexPath.row];
        [cell setCell:model];

    } else if (self->businessSection == sectionNumber) {
        model = [self->businessArr objectAtIndex:indexPath.row];
        [cell setCell:model];

    } else if (self->technologySection == sectionNumber) {
        model = [self->technologyArr objectAtIndex:indexPath.row];
        [cell setCell:model];

    } else if (self->sportsSection == sectionNumber) {
        model = [self->sportsArr objectAtIndex:indexPath.row];
        [cell setCell:model];

    } else if (self->entertainmentSection == sectionNumber) {
        model = [self->entertainmentArr objectAtIndex:indexPath.row];
        [cell setCell:model];

    } else if (self->scienceSection == sectionNumber) {
        model = [self->scienceArr objectAtIndex:indexPath.row];
        [cell setCell:model];

    } else {
        model = [self->healthArr objectAtIndex:indexPath.row];
        [cell setCell:model];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sectionNumber = [(AFIndexedCollectionView *)collectionView indexPath].section;
    NSDictionary *dict;
    
    if (self->generalSection == sectionNumber) {
        dict = [self->generalArr objectAtIndex:indexPath.row];
        
    } else if (self->businessSection == sectionNumber) {
        dict = [self->businessArr objectAtIndex:indexPath.row];
        
    } else if (self->technologySection == sectionNumber) {
        dict = [self->technologyArr objectAtIndex:indexPath.row];
        
    } else if (self->sportsSection == sectionNumber) {
        dict = [self->sportsArr objectAtIndex:indexPath.row];
        
    } else if (self->entertainmentSection == sectionNumber) {
        dict = [self->entertainmentArr objectAtIndex:indexPath.row];
        
    } else if (self->scienceSection == sectionNumber) {
        dict = [self->scienceArr objectAtIndex:indexPath.row];

    } else {
        dict = [self->healthArr objectAtIndex:indexPath.row];
    }
    
    WebViewController *vc = [[WebViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    vc = (WebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
    vc.urlPage = [dict valueForKey:@"sourceURL"];
    vc.sourceName = [dict valueForKey:@"sourceName"];
    NSLog(@"send data to next VC");
    
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    AFIndexedCollectionView *collectionView = (AFIndexedCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.section;
    
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

@end
