//
//  HuesColorParser.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuesColor;

// String -> color
@interface HuesColorParser : NSObject

+ (HuesColor *)parseColorFromString:(NSString *)string;
+ (HuesColor *)colorFromHex:(NSString *)hex;
+ (HuesColor *)colorFromRGB:(NSString *)rgb;
+ (HuesColor *)colorFromCocoaColor:(NSString *)string;

@end
