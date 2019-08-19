//
//  WebViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/31/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webview;
@property (strong, nonatomic) NSURL *urlPage;
@property (strong, nonatomic) NSString *sourceName;

@end
