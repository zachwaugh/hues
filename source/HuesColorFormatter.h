//
//  HuesColor+Formatting.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuesColor;

@interface HuesColorFormatter

+ (NSString *)hexForColor:(HuesColor *)color;
+ (NSString *)stringWithColor:(HuesColor *)color format:(NSString *)format;

@end
