//
//  IQActionSheetTitleBarButtonItem.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 12/28/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "IQActionSheetTitleBarButtonItem.h"

@implementation IQActionSheetTitleBarButtonItem
{
    UIView *_titleView;
    UIButton *_titleButton;
}
@synthesize font = _font;

-(nonnull instancetype)initWithTitle:(nullable NSString *)title
{
    self = [super init];
    if (self)
    {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _titleButton.enabled = NO;
        _titleButton.titleLabel.numberOfLines = 3;
        [_titleButton setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_titleButton setBackgroundColor:[UIColor clearColor]];
        [_titleButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self setTitle:title];
        [self setFont:[UIFont systemFontOfSize:13.0]];
        [_titleView addSubview:_titleButton];
        self.customView = _titleView;
    }
    return self;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    
    if (font)
    {
        _titleButton.titleLabel.font = font;
    }
    else
    {
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    if (titleColor)
    {
        [_titleButton setTitleColor:titleColor forState:UIControlStateDisabled];
    }
    else
    {
        [_titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [_titleButton setTitle:title forState:UIControlStateNormal];
}

@end



