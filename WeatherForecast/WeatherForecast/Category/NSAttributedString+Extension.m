//
//  NSAttributedString+YGExtension.m
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

+ (instancetype)attributedStringWithString:(NSString *)string {
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    shadow.shadowBlurRadius = 2;
    shadow.shadowOffset = CGSizeMake(1, -1);
    [attStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, string.length)];
    return attStr;
}


@end
