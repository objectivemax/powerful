//
//  NewsFilterViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "NewsFilterViewController.h"

#define ApiKeyString @"26c366cc0e174802bd368ece7bddd3d0"
#define UrlString @"https://newsapi.org/v2/sources?apiKey="

@interface NewsFilterViewController ()

@end

@implementation NewsFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getSources];
    
    dataParser = [[DataParser alloc] init];
    
    self.tableView.backgroundColor = [ProjectColor myLightBlueColor];
    
    // Navigation Title
    self.navigationItem.title = @"Filter";
    self.navigationController.navigationBar.titleTextAttributes = [AttributedString titleASNavigationBar];

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

            self.jsonSources = [[[self->dataParser parseFilter:responseObject]reverseObjectEnumerator] allObjects];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                NSLog(@"otpavivli update table");
            });
        }
    }];
    [dataTask resume];
}

#pragma mark TABLE VIEW DELEGATE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count of row: %lu", (unsigned long)self.jsonSources.count);
    return [self.jsonSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"newsFilterCell";
    
    NewsFilterModel *model = [self.jsonSources objectAtIndex:indexPath.row];
    
    NewsFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewsFilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setCell:model];
    cell.backgroundColor = [UIColor clearColor];
    
    // NOT ALLOWS SELECTION -------
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    WebViewController *vc = [[WebViewController alloc] init];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    vc = (WebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"webViewController"];
//    NSDictionary *dict = [self.jsonSources objectAtIndex:indexPath.row];
//    vc.urlPage = [dict valueForKey:@"sourceURL"];
//    NSLog(@"send data to next VC");
//    
//    [[self navigationController] pushViewController:vc animated:YES];
}

@end
