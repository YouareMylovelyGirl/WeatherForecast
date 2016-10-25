//
//  UIApplication+YGExtension.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Extension)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL    *documentsURL;
@property (nonatomic, readonly) NSString *documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL    *cachesURL;
@property (nonatomic, readonly) NSString *cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL    *libraryURL;
@property (nonatomic, readonly) NSString *libraryPath;

@end
