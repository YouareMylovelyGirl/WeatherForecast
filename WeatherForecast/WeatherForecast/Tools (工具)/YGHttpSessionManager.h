//
//  YGHttpSessionManager.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

@interface YGHttpSessionManager : AFHTTPSessionManager

+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
