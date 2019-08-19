//
//  NewsFilterViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/1/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFilterModel.h"
#import "NewsFilterCell.h"
#import "ProjectColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsFilterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    DataParser *dataParser;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *jsonSources;

@end

NS_ASSUME_NONNULL_END
