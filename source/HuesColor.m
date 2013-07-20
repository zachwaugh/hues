//
//  HuesColor.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor.h"

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

NSString * NSStringFromHSB(HuesHSB hsb)
{
	return [NSString stringWithFormat:@"{h: %.10f, s: %.10f, l: %.10f}", hsb.hue, hsb.saturation, hsb.brightness];
}