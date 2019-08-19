//
//  IQActionSheetToolbar.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetTitleBarButtonItem.h"

@interface IQActionSheetToolbar : UIToolbar

@property(nullable, nonatomic, strong) UIBarButtonItem *cancelButton;

@property(nullable, nonatomic, strong) IQActionSheetTitleBarButtonItem *titleButton;

@property(nullable, nonatomic, strong) UIBarButtonItem *doneButton;

@end
