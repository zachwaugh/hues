//
//  HuesColorParser.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

// String -> color
@interface HuesColorParser : NSObject

+ (NSColor *)parseColorFromString:(NSString *)string;
+ (NSColor *)colorFromHex:(NSString *)hex;
+ (NSColor *)colorFromRGB:(NSString *)rgb;
+ (NSColor *)colorFromCocoaColor:(NSString *)string;

@end
