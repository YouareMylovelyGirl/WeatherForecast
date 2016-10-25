//
//  YGWeatherChart.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ValuePosition) {
    ValuePositionUP,
    ValuePositionDown,
};

@interface WeatherLineChart : UIView

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *drawXPoints;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) ValuePosition valuePosition;

@end
