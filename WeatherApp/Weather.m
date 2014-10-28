//
//  Weather.m
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/21.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (id)initWithWeatherDetail:(NSString *)weatherDetail
             andTemperature:(float )temerature
                andDateTime:(NSDate *) dateTime
{
    _weatherDetail = weatherDetail;
    _temperature = temerature;
    _dateTime = dateTime;
    
    return self;
}

@end
