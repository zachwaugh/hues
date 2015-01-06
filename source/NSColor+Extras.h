//
//  NSColor+Extras.h
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSColor (Extras)

- (NSString *)hues_hex;
- (NSString *)hues_hexWithLowercase:(BOOL)lowercase;
- (NSString *)hues_hexWithFormat:(NSString *)format;
- (NSString *)hues_hexWithFormat:(NSString *)format useLowercase:(BOOL)lowercase;
- (NSString *)hues_rgb;
- (NSString *)hues_rgbWithDefaultFormat;
- (NSString *)hues_rgbWithFormat:(NSString *)format;
- (NSString *)hues_rgbaWithFormat:(NSString *)format;
- (NSString *)hues_hsb;
- (NSString *)hues_hsl;
- (NSString *)hues_hslWithDefaultFormat;
- (NSString *)hues_hslWithFormat:(NSString *)format;
- (NSString *)hues_hslaWithFormat:(NSString *)format;
- (NSColor *)hues_convertedColor;
+ (NSColor *)hues_colorFromHex:(NSString *)hex;

@end
