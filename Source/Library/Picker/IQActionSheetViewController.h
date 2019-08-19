//
//  IQActionSheetViewController.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IQActionSheetPickerView;

@interface IQActionSheetViewController : UIViewController

@property(nonatomic, strong, readonly) IQActionSheetPickerView *pickerView;

-(void)showPickerView:(IQActionSheetPickerView*)pickerView completion:(void (^)(void))completion;
-(void)dismissWithCompletion:(void (^)(void))completion;

@end
