//
//  Context.m
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/21.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import "Context.h"

NSString* const WEATHER_API_KEY = @"2437a6802a92ed96266ac0ab8e74c567";
NSString* const WEATHER_API_VERSION = @"2.5";

@implementation Context

+ (BOOL)is4_7inch
{
    return [UIScreen mainScreen].bounds.size.width == 375.0? YES : NO;
}

+ (BOOL)is5_5inch
{
    return [UIScreen mainScreen].bounds.size.width == 414.0? YES : NO;
}

//天気予報TableViewのセルのフォントサイズ
+ (NSInteger)weatherTableViewFontSize
{
    if ([self is4_7inch]) {
        return 18.0f;
    }
    if ([self is5_5inch]) {
        return 20.0f;
    }
    return 16.0f;
}

//天気予報TableViewのセルの高さ
+ (NSInteger)weatherTableViewHeight
{
    if ([self is4_7inch]) {
        return 70.0f;
    }
    if ([self is5_5inch]) {
        return 80.0f;
    }
    return 60.0f;
}

+ (NSString *)confirmLabel
{
    return @"確認";
}

+ (NSString *)alertWeatherMessageLabel
{
    return @"天気予報の情報を取得出来ませんでした";
}

+ (NSString *)alertLocationMessageLabel
{
    return @"位置情報を取得出来ませんでした";
}

+ (NSString *)okLabel
{
    return @"OK";
}

+ (NSString *)readingLabel
{
    return @"位置情報取得中";
}

+ (NSString *)titleLabel
{
    return @"明日の天気";
}

@end
