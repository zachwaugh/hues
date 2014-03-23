//
//  HuesColor.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuesColor : NSObject

// Default properties: 0.0 - 1.0
@property (nonatomic, assign, readonly) CGFloat red;
@property (nonatomic, assign, readonly) CGFloat green;
@property (nonatomic, assign, readonly) CGFloat blue;
@property (nonatomic, assign, readonly) CGFloat hue;
@property (nonatomic, assign, readonly) CGFloat saturation;
@property (nonatomic, assign, readonly) CGFloat lightness;
@property (nonatomic, assign, readonly) CGFloat alpha;
@property (nonatomic, assign, readonly) CGFloat HSBSaturation;
@property (nonatomic, assign, readonly) CGFloat brightness;

// Integer properties - 0-255, 0-100, 0-360 (depending on type)
@property (nonatomic, assign, readonly) NSInteger hues_red;
@property (nonatomic, assign, readonly) NSInteger hues_green;
@property (nonatomic, assign, readonly) NSInteger hues_blue;
@property (nonatomic, assign, readonly) NSInteger hues_hue;
@property (nonatomic, assign, readonly) NSInteger hues_alpha;
@property (nonatomic, assign, readonly) NSInteger hues_saturation; // HSL saturation
@property (nonatomic, assign, readonly) NSInteger hues_lightness; // HSL
@property (nonatomic, assign, readonly) NSInteger hues_HSBSaturation;
@property (nonatomic, assign, readonly) NSInteger hues_brightness; // HSB

#if TARGET_OS_IPHONE
@property (nonatomic, strong) UIColor *color;
#else
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, strong) NSColor *deviceColor;
@property (nonatomic, strong) NSColor *calibratedColor;
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
- (HuesColor *)colorWithRed:(CGFloat)red alpha:(CGFloat)alpha;
- (HuesColor *)colorWithGreen:(CGFloat)green;
- (HuesColor *)colorWithGreen:(CGFloat)green alpha:(CGFloat)alpha;
- (HuesColor *)colorWithBlue:(CGFloat)blue;
- (HuesColor *)colorWithBlue:(CGFloat)blue alpha:(CGFloat)alpha;
- (HuesColor *)colorWithAlpha:(CGFloat)alpha;
- (HuesColor *)colorWithHue:(CGFloat)hue;
- (HuesColor *)colorWithSaturation:(CGFloat)saturation; // HSL
- (HuesColor *)colorWithSaturation:(CGFloat)saturation alpha:(CGFloat)alpha;
- (HuesColor *)colorWithLightness:(CGFloat)lightness;  // HSL
- (HuesColor *)colorWithLightness:(CGFloat)lightness alpha:(CGFloat)alpha;  // HSL
- (HuesColor *)colorWithHSBSaturation:(CGFloat)saturation; // HSB
- (HuesColor *)colorWithBrightness:(CGFloat)brightness;  // HSB

@end