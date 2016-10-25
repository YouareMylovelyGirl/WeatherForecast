//
//  UILabel+YGFont.m
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import "UILabel+Font.h"
#import <objc/runtime.h>
@implementation UILabel (Font)

+ (void)load {
    
    [super load];
    
    Method oldImp = class_getInstanceMethod([self class], @selector(setFont:));
    Method newImp = class_getInstanceMethod([self class], @selector(mySetFont:));
    method_exchangeImplementations(oldImp, newImp);
}

- (void)mySetFont:(UIFont *)font {
    
    CGFloat fontSize = font.pointSize;
    if ([font.fontName isEqualToString:@"GillSans-Light"]) {
        [self mySetFont:[UIFont fontWithName:font.fontName size:fontSize]];
    } else {
        [self mySetFont:[UIFont fontWithName:@"PingFangSC-Light" size:fontSize]];
    }
}


@end
