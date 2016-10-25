//
//  YGWeatherMainController.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherMainController;

@protocol WeatherMainControllerDelegate <NSObject>

- (void)weatherMainControllerDidCloseAutoLocation;
- (void)weatherMainControllerDidDismiss;

@end

@interface WeatherMainController : UIViewController

@property (nonatomic, copy) NSDictionary *weatherData;

@property (nonatomic, weak) id<WeatherMainControllerDelegate> delegate;

- (void)updateToolBarWithCityname:(NSString *)cityname;
- (void)loadWeatherDataOfCityname:(NSString *)cityname cityid:(NSString *)cityid;

- (void)showLocatingTips;
- (void)hideLocatingTips;
- (void)showLocationFailedTips;

@end
