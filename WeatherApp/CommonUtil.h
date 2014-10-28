//
//  CommonUtil.h
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/21.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+FlatUI.h"

@interface CommonUtil : NSObject

+ (UIColor *)cellColorFromWeatherCode:(NSString *)weatherDetail;
+ (NSString *)timeString:(NSDate *)date;

@end
