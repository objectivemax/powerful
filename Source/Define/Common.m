//
//  Common.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/15/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "Common.h"
#include <sys/xattr.h>

BOOL isIPad()
{
    UIDevice *device = [UIDevice currentDevice];
    
    if ([device respondsToSelector:@selector(userInterfaceIdiom)])
    {
        UIUserInterfaceIdiom idiom = [device userInterfaceIdiom];
        switch (idiom) {
            case UIUserInterfaceIdiomPhone:
                return NO;  ///< iPhone
            case UIUserInterfaceIdiomPad:
                return YES;  ///< iPad
            default:
                return NO;  ///< Unknown idiom
        }
    }
    /// old device
    return NO;
}

BOOL isRetina()
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
        && [[UIScreen mainScreen] scale] == 2)
        return YES;  ///< iPhone 4
    /// other devices
    return NO;
}

NSString *criticalDataPath()
{
    NSString *path = [LibraryPath
                      stringByAppendingPathComponent:@"Private Documents/CriticalData"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        if (error)
        {
            Error(@"%@", [error localizedDescription]);
            return nil;
        }
    }
    return path;
}

id loadNib(Class aClass, NSString *nibName, id owner)
{
    NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:nibName
                                                     owner:owner
                                                   options:NULL];
    
    for (id niblet in niblets)
        if ([niblet isKindOfClass:aClass])
            return niblet;
    
    return nil;
}

CGSize CGSizeScaledToFitSize(CGSize size1, CGSize size2)
{
    float w, h;
    
    float k1 = size1.height / size1.width;
    float k2 = size2.height / size2.width;
    
    if (k1 > k2)
    {
        w = roundf(size1.width * size2.height / size1.height);
        h = size2.height;
    }
    else
    {
        w = size2.width;
        h = roundf(size1.height * size2.width / size1.width);
    }
    
    return CGSizeMake(roundf(w), roundf(h));
}

CGSize CGSizeScaledToFillSize(CGSize size1, CGSize size2)
{
    float w, h;
    
    float k1 = size1.height / size1.width;
    float k2 = size2.height / size2.width;
    
    if (k1 > k2)
    {
        w = size2.width;
        h = roundf(size1.height * size2.width / size1.width);
    }
    else
    {
        w = roundf(size1.width * size2.height / size1.height);
        h = size2.height;
    }
    
    return CGSizeMake(roundf(w), roundf(h));
}

CGRect CGRectWithSize(CGSize size)
{
    CGRect rect = CGRectZero;
    rect.size = size;
    return rect;
}

CGRect CGRectFillRect(CGRect rect1, CGRect rect2)
{
    CGRect rect;
    rect.size = CGSizeScaledToFillSize(rect1.size, rect2.size);
    rect.origin.x = roundf(rect2.origin.x + 0.5 * (rect2.size.width - rect.size.width));
    rect.origin.y = roundf(rect2.origin.y + 0.5 * (rect2.size.height - rect.size.height));
    return rect;
}

CGRect CGRectExpandToLabel(UILabel *label)
{
    float result = 1.;
    
    float width = label.frame.size.width;
    
    if (label.text)
    {
        CGSize textSize = CGSizeMake(width, 1000000.);
        
        CGRect textRect = [label.text boundingRectWithSize:textSize
                                                   options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                attributes:@{NSFontAttributeName: label.font}
                                                   context:nil];
        result = MAX(CGRectGetHeight(textRect), result);
    }
    
    return CGRectMake(label.frame.origin.x, label.frame.origin.y, width, result);
}

//void ShowAlert(NSString *title, NSString *message)
//{
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                  message:message
//                                                 delegate:nil
//                                        cancelButtonTitle:NSLocalizedString(@"ok", nil)
//                                        otherButtonTitles:nil];
//  [alert show];
//}

NSString * DeviceUDID()
{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

