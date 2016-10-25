//
//  YGCommonCityController.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommonCityControllerDelegate <NSObject>

- (void)commonCityControllerDidOpenAutoLocation;
- (void)commonCityControllerDidCloseAutoLocation;

- (void)commonCityControllerDidSelectCity:(NSString *)cityname isLocationCity:(BOOL)isLocationCity;
- (void)commonCityControllerDidAddCity;
- (void)commonCityControllerDidDeleteCity;
- (void)commonCityControllerDidReorderCity;

@end

@interface CommonCityController : UIViewController

@property (nonatomic, weak) id<CommonCityControllerDelegate> delegate;

@end
