//
//  YGWeatherGeneralInfoView.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWeatherGeneralItemWH 49

@interface WeatherGeneralInfoView : UIView

@property (nonatomic, weak) UILabel      *temperatureLabel;
@property (nonatomic, weak) UIImageView  *conditionIcon;
@property (nonatomic, weak) UILabel      *conditionLabel;
@property (nonatomic, weak) UIImageView  *indicatorIcon;
@property (nonatomic, weak) UIImageView  *PMIcon;
@property (nonatomic, weak) UILabel      *PMLabel;

- (void)updateWeatherInfoWithNowWeatherInfo:(NSDictionary *)nowWeatherInfo cityWeatherInfo:(NSDictionary *)cityWeatherInfo;

@end
