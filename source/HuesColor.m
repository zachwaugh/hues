//
//  HuesColor.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor.h"
#import "HuesColorConversion.h"

CGFloat HuesClampedValueForValueWithMinMax(CGFloat value, CGFloat min, CGFloat max)
{
	if (value > max) {
		return max;
	} else if (value < min) {
		return min;
	} else {
		return value;
	}
}

CGFloat HuesClampedValueForValue(CGFloat value)
{
	return HuesClampedValueForValueWithMinMax(value, 0, 1);
}

@interface HuesColor ()

@property (assign) BOOL createdWithRGB;

- (void)updateCache;
- (NSInteger)relativeBrightness;

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
	_createdWithRGB = YES;
	
	[self updateCache];
	
	return self;
}

- (id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
	self = [super init];
	if (!self) return nil;
	
	_hue = hue;
	_saturation = saturation;
	_lightness = lightness;
	_alpha = alpha;
	_createdWithRGB = NO;
	
	[self updateCache];
	
	return self;
}

- (id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
	HuesHSB hsb = HuesHSBMake(hue, saturation, brightness);
	HuesHSL hsl = HuesHSBToHSL(hsb);

	return [self initWithHue:hsl.hue saturation:hsl.saturation lightness:hsl.lightness alpha:alpha];
}

#if TARGET_OS_IPHONE
- (id)initWithColor:(UIColor *)color
{
	HuesRGB rgb = HuesRGBMake(color.redComponent, color.greenComponent, color.blueComponent);
	
	return [self initWithRed:rgb.red green:rgb.green blue:rgb.blue alpha:color.alphaComponent];
}

#else
- (id)initWithColor:(NSColor *)color
{
	HuesRGB rgb = HuesRGBMake(color.redComponent, color.greenComponent, color.blueComponent);
	
	return [self initWithRed:rgb.red green:rgb.green blue:rgb.blue alpha:color.alphaComponent];
}
#endif

+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
	return [[HuesColor alloc] initWithRed:red green:green blue:blue alpha:1.0f];
}

+ (HuesColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
	return [[HuesColor alloc] initWithRed:red green:green blue:blue alpha:1.0f];
}

+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness
{
	return [[HuesColor alloc] initWithHue:hue saturation:saturation lightness:lightness alpha:1.0f];
}

+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
	return [[HuesColor alloc] initWithHue:hue saturation:saturation lightness:lightness alpha:alpha];
}

+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness
{
	return [[HuesColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

+ (HuesColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha
{
	return [[HuesColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

#pragma mark - 

- (NSString *)description
{
	return [NSString stringWithFormat:@"color: %p - %@", self, NSStringFromRGB(self.RGB)];
}

- (void)updateCache
{
	if (self.createdWithRGB) {
		HuesHSL hsl = HuesRGBToHSL(self.RGB);
		
		_hue = hsl.hue;
		_saturation = hsl.saturation;
		_lightness = hsl.lightness;

	} else {
		HuesRGB rgb = HuesHSLToRGB(self.HSL);
		
		_red = rgb.red;
		_green = rgb.green;
		_blue = rgb.blue;
	}
		
#if TARGET_OS_IPHONE
	_color = [UIColor colorWithRed:self.red green:self.green blue:self.blue alpha:self.alpha];
#else
	_calibratedColor = [NSColor colorWithCalibratedRed:self.red green:self.green blue:self.blue alpha:self.alpha];
	_deviceColor = [NSColor colorWithDeviceRed:self.red green:self.green blue:self.blue alpha:self.alpha];
#endif
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

#pragma mark - 

- (BOOL)isDark
{
	return [self relativeBrightness] < 130;
}

// From: http://www.nbdtech.com/Blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx
- (NSInteger)relativeBrightness
{
	return sqrt((.241 * pow(self.hues_red, 2)) + (.691 * pow(self.hues_green, 2)) + (.068 * pow(self.hues_blue, 2)));
}

#pragma mark - Derived colors

- (HuesColor *)colorWithRed:(CGFloat)red
{
	return [self.class colorWithRed:red green:self.green blue:self.blue alpha:self.alpha];
}

- (HuesColor *)colorWithGreen:(CGFloat)green
{
	return [self.class colorWithRed:self.red green:green blue:self.blue alpha:self.alpha];
}

- (HuesColor *)colorWithBlue:(CGFloat)blue
{
	return [self.class colorWithRed:self.red green:self.green blue:blue alpha:self.alpha];
}

- (HuesColor *)colorWithAlpha:(CGFloat)alpha
{
	if (self.createdWithRGB) {
		return [self.class colorWithRed:self.red green:self.green blue:self.blue alpha:alpha];
	} else {
		return [self.class colorWithHue:self.hue saturation:self.saturation lightness:self.lightness alpha:alpha];
	}
}

- (HuesColor *)colorWithHue:(CGFloat)hue
{
	return [self.class colorWithHue:hue saturation:self.saturation lightness:self.lightness alpha:self.alpha];
}

- (HuesColor *)colorWithSaturation:(CGFloat)saturation
{
	return [self.class colorWithHue:self.hue saturation:saturation lightness:self.lightness alpha:self.alpha];
}

- (HuesColor *)colorWithLightness:(CGFloat)lightness
{
	return [self.class colorWithHue:self.hue saturation:self.saturation lightness:lightness alpha:self.alpha];
}

- (HuesColor *)colorWithHSBSaturation:(CGFloat)saturation
{
	return [self.class colorWithHue:self.hue saturation:saturation brightness:self.brightness alpha:self.alpha];
}

- (HuesColor *)colorWithBrightness:(CGFloat)brightness
{
	return [self.class colorWithHue:self.hue saturation:self.saturation brightness:brightness alpha:self.alpha];
}

@end