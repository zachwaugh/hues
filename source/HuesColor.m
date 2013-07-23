//
//  HuesColor.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor.h"
#import "HuesColorConversion.h"

#pragma mark - RGB

HuesRGB HuesRGBMake(CGFloat red, CGFloat green, CGFloat blue)
{
	HuesRGB rgb;
	rgb.red = red;
	rgb.green = green;
	rgb.blue = blue;
	
	return rgb;
}

BOOL HuesRGBEqualToRGB(HuesRGB rgb, HuesRGB rgb2)
{
	BOOL r = roundf(rgb.red * 255.f) == roundf(rgb2.red * 255.f);
	BOOL g = roundf(rgb.green * 255.f) == roundf(rgb2.green * 255.f);
	BOOL b = roundf(rgb.blue * 255.f) == roundf(rgb2.blue * 255.f);
	
	return (r && g && b);
}

NSString * NSStringFromRGB(HuesRGB rgb)
{
	return [NSString stringWithFormat:@"{r: %.3f, g: %.3f, b: %.3f}", rgb.red, rgb.green, rgb.blue];
}

#pragma mark - HSL

HuesHSL HuesHSLMake(CGFloat hue, CGFloat saturation, CGFloat lightness)
{
	HuesHSL hsl;
	hsl.hue = hue;
	hsl.saturation = saturation;
	hsl.lightness = lightness;
	
	return hsl;
}

BOOL HuesHSLEqualToHSL(HuesHSL hsl, HuesHSL hsl2)
{
	BOOL h = roundf(hsl.hue * 360.0f) == roundf(hsl2.hue * 360.0f);
	BOOL s = roundf(hsl.saturation * 100.f) == roundf(hsl2.saturation * 100.0f);
	BOOL l = roundf(hsl.lightness * 100.0f) == roundf(hsl2.lightness * 100.0f);
	
	return (h && s && l);
}

NSString * NSStringFromHSL(HuesHSL hsl)
{
	return [NSString stringWithFormat:@"{h: %.3f, s: %.3f, l: %.3f}", hsl.hue, hsl.saturation, hsl.lightness];
}

#pragma mark - HSB

HuesHSB HuesHSBMake(CGFloat hue, CGFloat saturation, CGFloat brightness)
{
	HuesHSB hsb;
	hsb.hue = hue;
	hsb.saturation = saturation;
	hsb.brightness = brightness;
	
	return hsb;
}

BOOL HuesHSBEqualToHSB(HuesHSB hsb, HuesHSB hsb2)
{
	BOOL h = roundf(hsb.hue * 360.0f) == roundf(hsb2.hue * 360.0f);
	BOOL s = roundf(hsb.saturation * 100.f) == roundf(hsb2.saturation * 100.0f);
	BOOL b = roundf(hsb.brightness * 100.0f) == roundf(hsb2.brightness * 100.0f);
	
	return (h && s && b);
}

CGFloat HuesClampedValueForValue(CGFloat value)
{
	if (value > 1) {
		return 1;
	} else if (value < 0) {
		return 0;
	} else {
		return value;
	}
}

NSString * NSStringFromHSB(HuesHSB hsb)
{
	return [NSString stringWithFormat:@"{h: %.10f, s: %.10f, l: %.10f}", hsb.hue, hsb.saturation, hsb.brightness];
}

@interface HuesColor ()

- (void)updateHSL;
- (void)updateRGB;

@end

@implementation HuesColor

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
	self = [super init];
	if (!self) return nil;
	
	_red = HuesClampedValueForValue(red);
	_green = HuesClampedValueForValue(green);
	_blue = HuesClampedValueForValue(blue);
	_alpha = HuesClampedValueForValue(alpha);
	
	[self updateHSL];
	
	return self;
}

- (id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
	self = [super init];
	if (!self) return nil;
	
	_hue = HuesClampedValueForValue(hue);
	_saturation = HuesClampedValueForValue(saturation);
	_lightness = HuesClampedValueForValue(lightness);
	_alpha = HuesClampedValueForValue(alpha);
	
	[self updateRGB];
	
	return self;
}

+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
	return [[HuesColor alloc] initWithRed:red green:green blue:blue alpha:1.0];
}

+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
	return [[HuesColor alloc] initWithRed:red green:green blue:blue alpha:1.0];
}

+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness
{
	return [[HuesColor alloc] initWithHue:hue saturation:saturation lightness:lightness alpha:1.0];
}

+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
	return [[HuesColor alloc] initWithHue:hue saturation:saturation lightness:lightness alpha:alpha];
}

- (void)updateRGB
{
	HuesRGB rgb = HuesHSLToRGB(HuesHSLMake(self.hue, self.saturation, self.lightness));
	
	self.red = rgb.red;
	self.green = rgb.green;
	self.blue = rgb.blue;
}

- (void)updateHSL
{
	HuesHSL hsl = HuesRGBToHSL(HuesRGBMake(self.red, self.green, self.blue));
	
	self.hue = hsl.hue;
	self.saturation = hsl.saturation;
	self.lightness = hsl.lightness;
}

#pragma mark - Structs

- (HuesRGB)RGB
{
	return HuesRGBMake(self.red, self.green, self.blue);
}

- (HuesHSL)HSL
{
	return HuesHSLMake(self.hue, self.saturation, self.lightness);
}

#pragma mark - Components

// RGB
- (int)hues_red
{
	return roundf(self.red * 255.0f);
}

- (int)hues_green
{
	return roundf(self.green * 255.0f);
}

- (int)hues_blue
{
	return roundf(self.blue * 255.0f);
}

- (int)hues_alpha
{
	return roundf(self.alpha * 100.0f);
}

// HSL
- (int)hues_hue
{
	return roundf(self.hue * 360.0f);
}

- (int)hues_saturation
{
	return (int)roundf(self.saturation * 100.0f);
}

- (int)hues_lightness
{
	return (int)roundf(self.lightness * 100.0f);
}

// HSB

- (CGFloat)HSBSaturation
{
	HuesHSB hsb = HuesHSLToHSB(self.HSL);
	return hsb.saturation;
}

- (int)hues_HSBSaturation
{
	return (int)roundf(self.HSBSaturation * 100.0f);
}

- (CGFloat)brightness
{
	HuesHSB hsb = HuesHSLToHSB(self.HSL);
	return hsb.brightness;
}

- (int)hues_brightness
{
	return (int)roundf(self.brightness * 100.0f);
}

#pragma mark - Cocoa colors

#if TARGET_OS_IPHONE

- (UIColor *)color
{
	return [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:self.alpha];
}

#else

- (NSColor *)calibratedColor
{
	return [NSColor colorWithCalibratedRed:self.red green:self.green blue:self.blue alpha:self.alpha];
}

- (NSColor *)deviceColor
{
	return [NSColor colorWithDeviceRed:self.red green:self.green blue:self.blue alpha:self.alpha];
}

#endif

@end