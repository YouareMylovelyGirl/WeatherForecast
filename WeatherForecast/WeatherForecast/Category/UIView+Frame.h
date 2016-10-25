//
//  UIView+YGFrame.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat sr_x;
@property (nonatomic, assign) CGFloat sr_y;
@property (nonatomic, assign) CGFloat sr_width;
@property (nonatomic, assign) CGFloat sr_height;
@property (nonatomic, assign) CGFloat sr_centerX;
@property (nonatomic, assign) CGFloat sr_centerY;
@property (nonatomic, assign) CGPoint sr_origin;
@property (nonatomic, assign) CGSize  sr_size;

@property (nonatomic, assign) CGFloat sr_top;
@property (nonatomic, assign) CGFloat sr_left;
@property (nonatomic, assign) CGFloat sr_bottom;
@property (nonatomic, assign) CGFloat sr_right;

@end
