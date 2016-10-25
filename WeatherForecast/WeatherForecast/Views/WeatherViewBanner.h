//
//  YGWeatherViewBanner.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewBanner : UIView

@property (nonatomic, weak) UILabel *loadingWeatherLabel;

- (void)updateWithCityname:(NSString *)cityname nowWeatherInfo:(NSDictionary *)nowWeatherInfo;

@end
