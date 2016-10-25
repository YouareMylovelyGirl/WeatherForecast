//
//  NSString+YGExtension.h
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark - String size

/**
 *  Accroding the font get the string's best fit size
 *
 *  @param font The string font
 *
 *  @return The string's size
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  Accroding the font and the width get the string's best fit size
 *
 *  @param font The string font
 *  @param maxW The string max width
 *
 *  @return The string's size
 */
- (CGSize)sizeWithFont:(UIFont *)font  maxWidth:(CGFloat)maxW;

/**
 *  Accroding the font and the width get the string's best fit size
 *
 *  @param font The string font
 *  @param maxH The string max height
 *
 *  @return The string's size
 */
- (CGSize)sizeWithFont:(UIFont *)font  maxHeight:(CGFloat)maxH;

@end
