//
//  HuesColor.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor.h"

BOOL fequal(CGFloat a, CGFloat b) {
	return (fabs(a - b) < FLT_EPSILON);
}

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
	BOOL redEqual = fequal(rgb.red, rgb2.red);
	BOOL greenEqual = fequal(rgb.green, rgb2.green);
	BOOL blueEqual = fequal(rgb.blue, rgb2.blue);
	
	BOOL allEqual = (redEqual && greenEqual && blueEqual);
	
	return allEqual;
	
	//return (rgb.red == rgb2.red && rgb.green == rgb2.green && rgb.blue == rgb2.blue);
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
	return (fequal(hsl.hue, hsl2.hue) && fequal(hsl.saturation, hsl2.saturation) && fequal(hsl.lightness, hsl2.lightness));
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
	return (fequal(hsb.hue, hsb2.hue) && fequal(hsb.saturation, hsb2.saturation) && fequal(hsb.brightness, hsb2.brightness));
}

NSString * NSStringFromHSB(HuesHSB hsb)
{
	return [NSString stringWithFormat:@"{h: %.3f, s: %.3f, l: %.3f}", hsb.hue, hsb.saturation, hsb.brightness];
}