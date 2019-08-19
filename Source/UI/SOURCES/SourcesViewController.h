//
//  SourcesViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "DataParser.h"
#import "WebViewController.h"
#import "SourceCollectionCell.h"
#import "SourceCell.h"
#import "SourceModel.h"
#import "ProjectColor.h"

@interface SourcesViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    DataParser *dataParser;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *jsonSources;

@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end
