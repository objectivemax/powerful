//
//  WebViewController.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/31/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.sourceName;
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:self.urlPage]];
}

@end
