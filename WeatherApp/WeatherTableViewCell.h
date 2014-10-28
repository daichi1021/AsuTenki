//
//  WeatherTableViewCell.h
//  WeatherApp
//
//  Created by Daichi Mizoguchi on 2014/10/20.
//  Copyright (c) 2014年 Daichi Mizoguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
