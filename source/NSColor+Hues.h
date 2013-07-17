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
- (int)hues_hue;
- (int)hues_alpha;
- (CGFloat)hues_saturationComponent; // HSL saturation
- (int)hues_saturation; // HSL saturation
- (CGFloat)hues_lightnessComponent; // HSL
- (int)hues_lightness; // HSL
- (int)hues_brightness; // HSB

- (NSColor *)hues_convertedColor;
- (BOOL)hues_isColorDark;
- (NSInteger)hues_relativeBrightness;

- (NSColor *)hues_colorWithRed:(CGFloat)red;
- (NSColor *)hues_colorWithGreen:(CGFloat)green;
- (NSColor *)hues_colorWithBlue:(CGFloat)blue;
- (NSColor *)hues_colorWithAlpha:(CGFloat)alpha;
- (NSColor *)hues_colorWithHue:(CGFloat)hue;
- (NSColor *)hues_colorWithSaturation:(CGFloat)saturation; // HSL
- (NSColor *)hues_colorWithLightness:(CGFloat)lightness;  // HSL

+ (NSColor *)hues_colorWithCalibratedHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

//- (NSString *)hues_hex;
//- (NSString *)hues_hexWithLowercase:(BOOL)lowercase;
//- (NSString *)hues_hexWithFormat:(NSString *)format;
//- (NSString *)hues_hexWithFormat:(NSString *)format useLowercase:(BOOL)lowercase;
//- (NSString *)hues_rgb;
//- (NSString *)hues_rgbWithDefaultFormat;
//- (NSString *)hues_rgbWithFormat:(NSString *)format;
//- (NSString *)hues_rgbaWithFormat:(NSString *)format;
//- (NSString *)hues_hsb;
//- (NSString *)hues_hsl;
//- (NSString *)hues_hslWithDefaultFormat;
//- (NSString *)hues_hslWithFormat:(NSString *)format;
//- (NSString *)hues_hslaWithFormat:(NSString *)format;
//- (NSString *)hues_NSColorCalibratedRGB;
//- (NSString *)hues_NSColorCalibratedHSB;
//- (NSString *)hues_NSColorDeviceRGB;
//- (NSString *)hues_NSColorDeviceHSB;
//- (NSString *)hues_UIColorRGB;
//- (NSString *)hues_UIColorHSB;

@end
