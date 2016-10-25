//
//  YGWeatherDataTool.m
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import "YGWeatherDataTool.h"
#import "YGLocationTool.h"
#import "YGUserDefaults.h"
#import "YGHttpSessionManager.h"

@implementation YGWeatherDataTool

#pragma mark - Load weatehr data

+ (void)loadWeatherDataCityname:(NSString *)cityname
                         cityid:(NSString *)cityid
                        success:(void (^)(NSDictionary *weatherData))success
                        failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *cachedWeatherDatas = [NSMutableDictionary dictionaryWithDictionary:[self cachedWeatherDatas]];
    if (cachedWeatherDatas[cityid]) {
        NSDictionary *weatherData = cachedWeatherDatas[cityid];
        if (success) {
            success(weatherData);
        }
        NSTimeInterval lastTime = [weatherData[@"time"] doubleValue];
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval interval = now - lastTime;
        if (interval < 3600) {
            return;
        }
    } else if (cachedWeatherDatas[cityname]) {
        NSDictionary *weatherData = cachedWeatherDatas[cityname];
        if (success) {
            success(weatherData);
        }
        NSTimeInterval lastTime = [weatherData[@"time"] doubleValue];
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval interval = now - lastTime;
        if (interval < 3600) {
            return;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (cityid) {
        params[@"cityid"] = cityid;
    } else {
        params[@"city"] = cityname;
    }
    [YGHttpSessionManager GET:@"http://apis.baidu.com/heweather/weather/free" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        // NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        // response.statusCode
        NSString *status = responseObject[@"HeWeather data service 3.0"][0][@"status"];
        if ([status isEqualToString:@"ok"]) {
            NSMutableDictionary *responseObjectM = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate];
            NSDictionary *timeDic = @{@"time": @(timeInterval)};
            [responseObjectM addEntriesFromDictionary:timeDic];
            if (cityid) {
                [cachedWeatherDatas addEntriesFromDictionary:@{cityid: responseObjectM}];
            } else {
                [cachedWeatherDatas addEntriesFromDictionary:@{cityname: responseObjectM}];
            }
            [self saveCachedWeatherDatas:cachedWeatherDatas];
            if (success) {
                success(responseObjectM);
            }
        } else {
//            HSLog(@"status: %@", status);
            if (failure) {
                failure(nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        HSLog(@"error: %@", error);
        if (cachedWeatherDatas[cityid]) {
            if (failure) {
                failure(nil);
            }
        } else if (cachedWeatherDatas[cityname]) {
            if (failure) {
                failure(nil);
            }
        } else {
            if (failure) {
                failure(error);
            }
        }
    }];
}

#pragma mark - Get method

+ (NSString *)defaultCityname {
    
    NSArray *commonCities = [self commonCities];
    NSString *cityname;
    if (commonCities.count > 0) {
        cityname = commonCities[0];
    } else {
        cityname = @"北京";
    }
    return cityname;
}

+ (NSString *)defaultCityid {
    
    return [YGWeatherDataTool cityidOfCityname:[self defaultCityname]];
}

+ (NSArray *)commonCities {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"commonCities.plist"];
    NSArray *commonCities = [NSArray arrayWithContentsOfFile:filePath];
    if (!commonCities) {
        commonCities = @[@"北京", @"上海", @"广州", @"深圳", @"成都"];
    }
    return commonCities;
}

+ (NSArray *)hotCities {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hotCities" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSArray *)allCities {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allCities" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSArray *)allCitiesDics {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allCitiesDics" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSDictionary *)cachedWeatherDatas {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"cachedWeatherDatas.plist"];
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

#pragma mark - Save method

+ (void)saveCommonCities:(NSArray *)commonCities {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"commonCities.plist"];
    [commonCities writeToFile:filePath atomically:YES];
}

+ (void)saveCachedWeatherDatas:(NSDictionary *)cachedWeatherDatas {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"cachedWeatherDatas.plist"];
    [cachedWeatherDatas writeToFile:filePath atomically:YES];
}

#pragma mark - Tool method

+ (NSString *)cityidOfCityname:(NSString *)cityname {
    
    NSArray *allCitiesDics = [YGWeatherDataTool allCitiesDics];
    for (NSInteger i = 0; i < allCitiesDics.count; i++) {
        NSDictionary *cityDic = allCitiesDics[i];
        if ([cityname isEqualToString:cityDic[@"city"]]) {
            return cityDic[@"id"];
        }
    }
    return nil;
}



@end
