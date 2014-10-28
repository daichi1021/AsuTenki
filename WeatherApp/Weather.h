//
//  Weather.h
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/21.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (strong, nonatomic) NSString *weatherDetail;
@property (assign, nonatomic) float temperature;
@property (strong, nonatomic) NSDate *dateTime;

- (id)initWithWeatherDetail:(NSString *)weatherDetail
             andTemperature:(float )temerature
                andDateTime:(NSDate *) dateTime;

@end
