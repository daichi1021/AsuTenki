//
//  CommonUtil.m
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/21.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (UIColor *)cellColorFromWeatherCode:(NSString *)weatherDetail
{
    if ([weatherDetail isEqualToString:@"Clear"]) {
        return [UIColor carrotColor];
    }
    
    if ([weatherDetail isEqualToString:@"Clouds"]) {
        return [UIColor concreteColor];
    }
    
    if ([weatherDetail isEqualToString:@"Rain"]) {
        return [UIColor peterRiverColor];
    }
    
    return [UIColor whiteColor];
}


+ (NSString *)timeString:(NSDate *)date
{
    NSDateFormatter *defaultDateFormatter = [[NSDateFormatter alloc] init];
    defaultDateFormatter.dateFormat = @"HH:mm";
    
    return [defaultDateFormatter stringFromDate:date];
}

@end
