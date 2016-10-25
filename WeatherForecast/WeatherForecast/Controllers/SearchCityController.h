//
//  YGSearchCityController.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchCityControllerDelegate <NSObject>

- (void)searchCityControllerDidAddCity;
- (void)searchCityControllerDidAddMoreThan12Cities;
- (void)searchCityControllerCityHasAdded;

@end

@interface SearchCityController : UIViewController

@property (nonatomic, weak) id<SearchCityControllerDelegate> delegate;

@end
