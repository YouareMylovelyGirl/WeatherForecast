//
//  YGLocationTool.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol YGLocationToolDelegate <NSObject>

@optional
- (void)locationToolLocationServicesDisabled;
- (void)locationToolLocationServicesAuthorizationStatusDenied;
- (void)locationToolLocationServicesAuthorizationStatusAuthorized;
- (void)locationToolLocationServicesLocating;
- (void)locationToolLocationSuccess;
- (void)locationToolLocationFailed;

@end

@interface YGLocationTool : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<YGLocationToolDelegate> delegate;

@property (nonatomic, assign, getter=isAutoLocation) BOOL autoLocation;

@property (nonatomic, copy  ) NSString *currentLocationCity;
@property (nonatomic, copy  ) NSString *currentLocationState;

@property (nonatomic, strong) NSNumber *currentLocationLongitude;
@property (nonatomic, strong) NSNumber *currentLocationLatitude;

- (void)resetLocation;

- (void)beginLocation;

@end
