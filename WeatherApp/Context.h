//
//  Context.h
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/21.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIScreen.h>

extern NSString* const WEATHER_API_KEY;
extern NSString* const WEATHER_API_VERSION;

@interface Context : NSObject

+ (NSInteger)weatherTableViewFontSize;
+ (NSInteger)weatherTableViewHeight;

+ (NSString *)confirmLabel;
+ (NSString *)alertWeatherMessageLabel;
+ (NSString *)alertLocationMessageLabel;
+ (NSString *)okLabel;
+ (NSString *)readingLabel;
+ (NSString *)titleLabel;

@end
