//
//  UITableView+SlideMenuControllerOC.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "UITableView+SlideMenuControllerOC.h"

@implementation UITableView (SlideMenuControllerOC)

-(void)registerCellClass:(Class) cellClass {
    NSString *identifier = NSStringFromClass(cellClass);
    [self registerClass:cellClass forCellReuseIdentifier:identifier];
}

-(void)registerCellNib:(Class) cellClass {
    NSString *identifier = NSStringFromClass(cellClass);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identifier];
}

-(void)registerHeaderFooterViewClass:(Class) viewClass {
    NSString *identifier = NSStringFromClass(viewClass);
    [self registerClass:viewClass forCellReuseIdentifier:identifier];
}

-(void)registerHeaderFootViewNib:(Class) viewClass {
    NSString *identifier = NSStringFromClass(viewClass);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identifier];
}

@end


