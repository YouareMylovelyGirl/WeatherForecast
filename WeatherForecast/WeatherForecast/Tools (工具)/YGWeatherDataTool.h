//
//  YGWeatherDataTool.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGWeatherDataTool : NSObject

+ (void)loadWeatherDataCityname:(NSString *)cityname
                         cityid:(NSString *)cityid
                        success:(void (^)(NSDictionary *weatherData))success
                        failure:(void (^)(NSError *error))failure;

+ (NSString *)defaultCityname;
+ (NSString *)defaultCityid;

+ (NSArray *)commonCities;
+ (NSArray *)hotCities;
+ (NSArray *)allCities;
+ (NSArray *)allCitiesDics;

+ (NSDictionary *)cachedWeatherDatas;

+ (void)saveCommonCities:(NSArray *)commonCities;
+ (void)saveCachedWeatherDatas:(NSDictionary *)cachedWeatherDatas;

+ (NSString *)cityidOfCityname:(NSString *)cityname;


@end
