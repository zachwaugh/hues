//
//  HuesColorParser.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HuesColor.h"

HuesHSB HuesRGBToHSB(HuesRGB rgb);
HuesHSL HuesRGBToHSL(HuesRGB rgb);
HuesRGB HuesHSLToRGB(HuesHSL hsl);
HuesHSB HuesHSLToHSB(HuesHSL hsl);
HuesHSL HuesHSBToHSL(HuesHSB hsb);
CGFloat HuesHueToRGB(CGFloat p, CGFloat q, CGFloat t);

@interface HuesColorParser : NSObject

+ (NSColor *)parseColorFromString:(NSString *)string;
+ (NSColor *)colorFromHex:(NSString *)hex;
+ (NSColor *)colorFromRGB:(NSString *)rgb;
+ (NSColor *)colorFromCocoaColor:(NSString *)string;

@end
