//
//  NSColor+Extras.m
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "NSColor+Hues.h"

@implementation NSColor (Hues)

#pragma mark - Components

- (int)hues_red
{
	return roundf(self.hues_convertedColor.redComponent * 255.0f);
}

- (int)hues_green
{
	return roundf(self.hues_convertedColor.greenComponent * 255.0f);
}

- (int)hues_blue
{
	return roundf(self.hues_convertedColor.blueComponent * 255.0f);
}

- (int)hues_alpha
{
	return roundf(self.hues_convertedColor.alphaComponent * 100.0f);
}

- (int)hues_hue
{
	return roundf(self.hues_convertedColor.hueComponent * 360.0f);
}

// HSL saturation
- (CGFloat)hues_saturationComponent
{
	NSColor *color = self.hues_convertedColor;
	int hue;
	CGFloat red, green, blue, alpha, saturation, lightness, max, min, delta;
	
	red = color.redComponent;
	green = color.greenComponent;
	blue = color.blueComponent;
	alpha = color.alphaComponent;
	
	max = MAX(red, MAX(green, blue));
	min = MIN(red, MIN(green, blue));
	hue = roundf(color.hueComponent * 360.0f);
	hue = (hue >= 360) ? 0 : hue;
	
	lightness = (max + min) / 2.0;
	
	if (max == min) {
		hue = 0;
		saturation = 0;
	} else {
		delta = max - min;
		saturation = (lightness > 0.5) ? delta / (2 - max - min) : delta / (max + min);
	}
	
	return saturation;
}

// HSL
- (int)hues_saturation
{
	return (int)roundf(self.hues_saturationComponent * 100.0f);
}

// HSB
- (int)hues_brightness
{
	return roundf(self.hues_convertedColor.brightnessComponent * 100.0f);
}

- (CGFloat)hues_lightnessComponent
{
	NSColor *color = self.hues_convertedColor;
	int hue;
	CGFloat red, green, blue, alpha, lightness, max, min;

	red = color.redComponent;
	green = color.greenComponent;
	blue = color.blueComponent;
	alpha = color.alphaComponent;
	
	max = MAX(red, MAX(green, blue));
	min = MIN(red, MIN(green, blue));
	hue = roundf(color.hueComponent * 360.0f);
	hue = (hue >= 360) ? 0 : hue;
	
	lightness = (max + min) / 2.0;
	
	return lightness;
}

- (int)hues_lightness
{
	return (int)roundf(self.hues_lightnessComponent * 100.0f);
}

#pragma mark - Derived Colors

- (NSColor *)hues_convertedColor
{
  NSColor *color;
  
	// If not in calibrated or device color space, make calibrated
  if (self.colorSpaceName != NSCalibratedRGBColorSpace && self.colorSpaceName != NSDeviceRGBColorSpace) {
    color = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
  } else {
    color = self;
  }
  
  return color;
}

- (NSColor *)hues_colorWithRed:(CGFloat)red
{
	return [NSColor colorWithCalibratedRed:red green:self.greenComponent blue:self.blueComponent alpha:self.alphaComponent];
}

- (NSColor *)hues_colorWithGreen:(CGFloat)green
{
	return [NSColor colorWithCalibratedRed:self.redComponent green:green blue:self.blueComponent alpha:self.alphaComponent];
}

- (NSColor *)hues_colorWithBlue:(CGFloat)blue
{
	return [NSColor colorWithCalibratedRed:self.redComponent green:self.greenComponent blue:blue alpha:self.alphaComponent];
}

- (NSColor *)hues_colorWithAlpha:(CGFloat)alpha
{
	return [NSColor colorWithCalibratedRed:self.redComponent green:self.greenComponent blue:self.blueComponent alpha:alpha];
}

- (NSColor *)hues_colorWithHue:(CGFloat)hue
{
	return [NSColor hues_colorWithCalibratedHue:hue saturation:self.hues_saturationComponent lightness:self.hues_lightnessComponent alpha:self.alphaComponent];
}

- (NSColor *)hues_colorWithSaturation:(CGFloat)saturation
{
	return [NSColor hues_colorWithCalibratedHue:self.hueComponent saturation:saturation lightness:self.hues_lightnessComponent alpha:self.alphaComponent];
}

- (NSColor *)hues_colorWithLightness:(CGFloat)lightness
{
	return [NSColor hues_colorWithCalibratedHue:self.hueComponent saturation:self.hues_saturationComponent lightness:lightness alpha:self.alphaComponent];
}

#pragma mark - Color Comparison

- (BOOL)hues_isColorDark
{
	return [self hues_relativeBrightness] < 130;
}

// From: http://www.nbdtech.com/Blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx
- (NSInteger)hues_relativeBrightness
{
	NSColor *color = [self hues_convertedColor];
	
	return sqrt((.241 * pow(color.hues_red, 2)) + (.691 * pow(color.hues_green, 2)) + (.068 * pow(color.hues_blue, 2)));
}

#pragma mark - Color creation

+ (NSColor *)hues_colorWithCalibratedHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
	CGFloat red, green, blue;
}

@end
