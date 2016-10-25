//
//  YGWeatherDetailInfoView.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWeatherDetailItemWH 39
#define kHourlyWeatherInfoViewH kWeatherDetailItemWH * 4
#define kDailyWeatherInfoViewH  kWeatherDetailItemWH * 4 + 150

@interface WeatherDetailInfoView : UIScrollView

@property (nonatomic, copy) NSDictionary *weatherData;


@end
