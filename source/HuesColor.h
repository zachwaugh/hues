//
//  HuesColor.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

// RGB

typedef struct {
  CGFloat red;
	CGFloat green;
	CGFloat blue;
} HuesRGB;

typedef struct {
  CGFloat hue;
	CGFloat saturation;
	CGFloat lightness;
} HuesHSL;

typedef struct {
  CGFloat hue;
	CGFloat saturation;
	CGFloat brightness;
} HuesHSB;

// RGB
HuesRGB HuesRGBMake(CGFloat red, CGFloat green, CGFloat blue);
BOOL HuesRGBEqualToRGB(HuesRGB rgb, HuesRGB rgb2);
NSString * NSStringFromRGB(HuesRGB rgb);

// HSL
HuesHSL HuesHSLMake(CGFloat hue, CGFloat saturation, CGFloat lightness);
BOOL HuesHSLEqualToHSL(HuesHSL hsl, HuesHSL hsl2);
NSString * NSStringFromHSL(HuesHSL hsl);

// HSB
HuesHSB HuesHSBMake(CGFloat hue, CGFloat saturation, CGFloat brightness);
BOOL HuesHSBEqualToHSB(HuesHSB hsb, HuesHSB hsb2);
NSString * NSStringFromHSB(HuesHSB hsb);

@interface HuesColor : NSObject

@property (assign, nonatomic) CGFloat red;
@property (assign, nonatomic) CGFloat green;
@property (assign, nonatomic) CGFloat blue;
@property (assign, nonatomic) CGFloat hue;
@property (assign, nonatomic) CGFloat saturation;
@property (assign, nonatomic) CGFloat lightness;
@property (assign, nonatomic) CGFloat alpha;

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;
+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

- (int)hues_red;
- (int)hues_green;
- (int)hues_blue;
- (int)hues_hue;
- (int)hues_alpha;
- (int)hues_saturation; // HSL saturation
- (int)hues_lightness; // HSL

- (CGFloat)HSBSaturation; // HSB saturation
- (int)hues_HSBSaturation;
- (CGFloat)brightness;
- (int)hues_brightness; // HSB

#if TARGET_OS_IPHONE

- (UIColor *)color;

#else

- (NSColor *)calibratedColor;
- (NSColor *)deviceColor;

#endif

@end