//
//  WeatherCollectionCell.m
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/8/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import "WeatherCollectionCell.h"

#define    SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define    SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height

#define LEFT 16
#define RIGHT 16
#define TOP 10
#define BIG_TOP 40

#define LABEL_HEIGHT 22

#define CELL_WIDTH 150
#define CELL_HEIGHT 80

@implementation WeatherCollectionCell

- (void) setCell:(NSArray *)model {
    
    // CLEAN CELL BEFORE REUSE
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    self.contentView.backgroundColor = nil;
    
    // MAIN VIEW
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, CELL_WIDTH, CELL_HEIGHT - 8 - 8)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 20;
    
    //shadow
    self.mainView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.layer.shadowOpacity = 0.7f;
    self.mainView.layer.shadowRadius = 4.0;
    [self.contentView addSubview:self.mainView];
    
    //type
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP, self.mainView.frame.size.width - LEFT - RIGHT, LABEL_HEIGHT)];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.attributedText =
        [AttributedString subheadASWithColor:[UIColor blackColor] string:[model valueForKey:@"type"]];
    [self.mainView addSubview:self.typeLabel];
    
    
    if ([[model valueForKey:@"type"] isEqualToString:@"sunrise"]) {
        
        // convert seconds to date
        NSInteger timeInSeconds = [[model valueForKey:@"sunrise"] integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInSeconds];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm:ss a"];
        NSString *sunrise = [formatter stringFromDate:date];

        // set sunrise time
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + LABEL_HEIGHT, self.mainView.frame.size.width - LEFT - RIGHT, LABEL_HEIGHT)];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.attributedText =
        [AttributedString bodyASWithColor:[UIColor blackColor] string:sunrise];
        [self.mainView addSubview:self.valueLabel];
    }
    
    
    if ([[model valueForKey:@"type"] isEqualToString:@"sunset"]) {
        
        // convert seconds to date
        NSInteger timeInSeconds = [[model valueForKey:@"sunset"] integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInSeconds];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm:ss a"];
        NSString *sunset = [formatter stringFromDate:date];
        
        // set sunset time
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + LABEL_HEIGHT, self.mainView.frame.size.width - LEFT - RIGHT, LABEL_HEIGHT)];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.attributedText =
        [AttributedString bodyASWithColor:[UIColor blackColor] string:sunset];
        [self.mainView addSubview:self.valueLabel];
    }
    
    if ([[model valueForKey:@"type"] isEqualToString:@"wind"]) {
        // set wind
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + LABEL_HEIGHT, self.mainView.frame.size.width - LEFT - RIGHT, LABEL_HEIGHT)];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.attributedText =
        [AttributedString bodyASWithColor:[UIColor blackColor] string:[NSString stringWithFormat:@"N %@ mph",[model valueForKey:@"wind"]]];
        [self.mainView addSubview:self.valueLabel];
    }
    
    if ([[model valueForKey:@"type"] isEqualToString:@"humidity"]) {
        // set humidity
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT, TOP + LABEL_HEIGHT, self.mainView.frame.size.width - LEFT - RIGHT, LABEL_HEIGHT)];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.attributedText =
        [AttributedString bodyASWithColor:[UIColor blackColor] string:[NSString stringWithFormat:@"%@ %%",[model valueForKey:@"humidity"]]];
        [self.mainView addSubview:self.valueLabel];
    }

    
    
    






}

@end
