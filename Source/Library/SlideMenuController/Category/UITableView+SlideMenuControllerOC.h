//
//  UITableView+SlideMenuControllerOC.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 5/23/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SlideMenuControllerOC)

-(void)registerCellClass:(Class) cellClass;

-(void)registerCellNib:(Class) cellClass;

-(void)registerHeaderFooterViewClass:(Class) viewClass;

-(void)registerHeaderFootViewNib:(Class) viewClass;

@end
