//
//  NSColor+Extras.h
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSColor (Hues)

- (int)hues_red;
- (int)hues_green;
- (int)hues_blue;
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
- (NSString *)hues_NSColorCalibratedRGB;
- (NSString *)hues_NSColorCalibratedHSB;
- (NSString *)hues_NSColorDeviceRGB;
- (NSString *)hues_NSColorDeviceHSB;
- (NSString *)hues_UIColorRGB;
- (NSString *)hues_UIColorHSB;
- (NSColor *)hues_convertedColor;
- (BOOL)hues_isColorDark;
- (NSInteger)hues_relativeBrightness;

@end
