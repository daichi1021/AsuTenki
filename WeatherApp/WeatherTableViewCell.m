//
//  WeatherTableViewCell.m
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/20.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import "WeatherTableViewCell.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "Context.h"

@implementation WeatherTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _temperatureLabel.textColor = [UIColor wetAsphaltColor];
    _temperatureLabel.font = [UIFont boldFlatFontOfSize:[Context weatherTableViewFontSize]];
    
    _timeLabel.textColor = [UIColor wetAsphaltColor];
    _timeLabel.font = [UIFont boldFlatFontOfSize:[Context weatherTableViewFontSize]];
}

@end
