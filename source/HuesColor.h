//
//  HuesColor.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

@interface HuesColor : NSObject

// Default properties: 0-1
@property (assign, nonatomic, readonly) CGFloat red;
@property (assign, nonatomic, readonly) CGFloat green;
@property (assign, nonatomic, readonly) CGFloat blue;
@property (assign, nonatomic, readonly) CGFloat hue;
@property (assign, nonatomic, readonly) CGFloat saturation;
@property (assign, nonatomic, readonly) CGFloat lightness;
@property (assign, nonatomic, readonly) CGFloat alpha;
@property (assign, nonatomic, readonly) CGFloat HSBSaturation;
@property (assign, nonatomic, readonly) CGFloat brightness;

// Integer properties - 0-255, 0-100, 0-360 (depending on type)
@property (assign, nonatomic, readonly) int hues_red;
@property (assign, nonatomic, readonly) int hues_green;
@property (assign, nonatomic, readonly) int hues_blue;
@property (assign, nonatomic, readonly) int hues_hue;
@property (assign, nonatomic, readonly) int hues_alpha;
@property (assign, nonatomic, readonly) int hues_saturation; // HSL saturation
@property (assign, nonatomic, readonly) int hues_lightness; // HSL
@property (assign, nonatomic, readonly) int hues_HSBSaturation;
@property (assign, nonatomic, readonly) int hues_brightness; // HSB

#if TARGET_OS_IPHONE
@property (strong) UIColor *color;
#else
@property (strong) NSColor *deviceColor;
@property (strong) NSColor *calibratedColor;
#endif

#pragma mark - Constructors

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;
- (id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

#if TARGET_OS_IPHONE
- (id)initWithColor:(UIColor *)color;
#else
- (id)initWithColor:(NSColor *)color;
#endif

+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;
+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;
+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness;
+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

#pragma mark - 

- (BOOL)isDark;

#pragma mark - Derived colors

- (HuesColor *)colorWithRed:(CGFloat)red;
- (HuesColor *)colorWithGreen:(CGFloat)green;
- (HuesColor *)colorWithBlue:(CGFloat)blue;
- (HuesColor *)colorWithAlpha:(CGFloat)alpha;
- (HuesColor *)colorWithHue:(CGFloat)hue;
- (HuesColor *)colorWithSaturation:(CGFloat)saturation; // HSL
- (HuesColor *)colorWithLightness:(CGFloat)lightness;  // HSL
- (HuesColor *)colorWithHSBSaturation:(CGFloat)saturation; // HSB
- (HuesColor *)colorWithBrightness:(CGFloat)brightness;  // HSB

@end