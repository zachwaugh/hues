//
//  HuesColorParser.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorParser.h"
#import "NSScanner+Hues.h"

HuesHSB HuesRGBToHSB(HuesRGB rgb)
{
	CGFloat r = rgb.red, g = rgb.green, b = rgb.blue;
	CGFloat max = MAX(MAX(r, g), b);
	CGFloat min = MIN(MIN(r, g), b);
	CGFloat chroma = max - min;
	
	CGFloat hue;
	
	if (chroma == 0) {
		hue = 0.f;
	} else if (max == r) {
		hue = fmod(((g - b) / chroma), 6);
	} else if (max == g) {
		hue = ((b - r) / chroma) + 2;
	} else if (max == b) {
		hue = ((r - g) / chroma) + 4;
	} else {
		hue = 0.f;
	}
	
	hue = (hue * 60.0f) / 360.0f;
	
	CGFloat brightness = max;
	CGFloat saturation = (chroma == 0) ? 0 : chroma / brightness;
	
	return HuesHSBMake(hue, saturation, brightness);
}

HuesHSL HuesRGBToHSL(HuesRGB rgb)
{
	CGFloat r = rgb.red, g = rgb.green, b = rgb.blue;
	CGFloat max = MAX(MAX(r, g), b);
	CGFloat min = MIN(MIN(r, g), b);
	CGFloat chroma = max - min;
	
	CGFloat hue = 0;
	
	if (max == r) {
		hue = fmod(((g - b) / chroma), 6);
	} else if (max == g) {
		hue = ((b - r) / chroma) + 2;
	} else if (max == b) {
		hue = ((r - g) / chroma) + 4;
	}
	
	CGFloat lightness = (max + min) * 0.5;
	CGFloat saturation = (chroma == 0) ? 0 : chroma / (1 - (2 * lightness - 1));
	
	return HuesHSLMake(hue, saturation, lightness);
}

HuesRGB HuesHSLToRGB(HuesHSL hsl)
{
	CGFloat h = hsl.hue, s = hsl.saturation, l = hsl.lightness;
	CGFloat r, g, b;
	
	CGFloat v1, v2;
	
	if (s == 0) {
		// If saturation is 0, color is the same as lightness
		r = g = b = l;
	} else {
		if (l < 0.5) {
			v2 = l * (1 + s);
		} else {
			v2 = (l + s) - (s * l);
		}
		
		v1 = 2 * l - v2;
		r = HuesHueToRGB(v1, v2, h + (1 / 3.0));
		g = HuesHueToRGB(v1, v2, h);
		b = HuesHueToRGB(v1, v2, h - (1 / 3.0));
	}
	
	return HuesRGBMake(r, g, b);
}

CGFloat HuesHueToRGB(CGFloat v1, CGFloat v2, CGFloat vh)
{
	if (vh < 0) {
		vh += 1;
	}
	
	if (vh > 1) {
		vh -= 1;
	}
	
	if ((6 * vh) < 1) {
		return (v1 + (v2 - v1) * 6 * vh);
	}
	
	if ((2 * vh) < 1) {
		return (v2);
	}
	
	if ((3 * vh) < 2) {
		return (v1 + (v2 - v1) * ((2 / 3.0 - vh) * 6));
	}
	
	return v1;
}

HuesHSB HuesHSLToHSB(HuesHSL hsl)
{
	// void hsl_to_hsv(double hh, double ss, double ll, double* h, double* s, double *v)
	CGFloat hue = hsl.hue;
	CGFloat ll = hsl.lightness * 2;
	CGFloat ss = hsl.saturation * ((ll <= 1) ? ll : 2 - ll);
	
	CGFloat brightness = (ll + ss) / 2;
	CGFloat saturation = (2 * ss) / (ll + ss);
	
	return HuesHSBMake(hue, saturation, brightness);
}

HuesHSL HuesHSBToHSL(HuesHSB hsb)
{
	CGFloat hue = hsb.hue;
	CGFloat lightness = (2 - hsb.saturation) * hsb.brightness;
	CGFloat saturation = hsb.saturation * hsb.brightness;
	saturation /= (lightness <= 1) ? lightness : 2 - lightness;
	lightness /= 2;
	
	return HuesHSLMake(hue, saturation, lightness);
}

@implementation HuesColorParser

+ (NSColor *)parseColorFromString:(NSString *)string
{
	// Determine parser to use
	if ([string hasPrefix:@"rgb"]) {
		return [self colorFromRGB:string];
	} else if ([string hasPrefix:@"[NSColor"] || [string hasPrefix:@"[UIColor"]) {
		return [self colorFromCocoaColor:string];
	} else {
		return [self colorFromHex:string];
	}
}

+ (NSColor *)colorFromHex:(NSString *)hex
{
	// Accepts:
	// #FFFFFF
	// FFFFFF
	// ffffff
	
  // remove any # signs
  hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
  
  if (hex == nil || hex.length < 6) return nil;
  if (hex.length > 6) hex = [hex substringToIndex:6]; // chop off any extra characters
  
	NSColor *result = nil;
	unsigned int colorCode = 0;
	unsigned char redByte, greenByte, blueByte;
	
	NSScanner *scanner = [NSScanner scannerWithString:hex];
	if (![scanner scanHexInt:&colorCode]) {
		return nil;
	}
  
	redByte = (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte = (unsigned char) (colorCode);	// masks off high bits
	result = [NSColor colorWithCalibratedRed:(CGFloat)redByte / 255 green:(CGFloat)greenByte / 255 blue:(CGFloat)blueByte / 255 alpha:1.0];
	
	return result;
}

+ (NSColor *)colorFromRGB:(NSString *)rgb
{
	// Accepts:
	// rgb(255, 255, 255)
	// rgba(255, 255, 255, 1)
	
	if (![rgb hasPrefix:@"rgb"] || ![rgb hasSuffix:@")"]) return nil;
	
	int red = 255, green = 255, blue = 255;
	float alpha = 1.0;
	
	NSScanner *scanner = [[NSScanner alloc] initWithString:rgb];
	
	[scanner scanUpToString:@"(" intoString:NULL];
	[scanner scanString:@"(" intoString:NULL];
	[scanner scanInt:&red];
	[scanner scanUpToString:@"," intoString:NULL];
	[scanner scanString:@"," intoString:NULL];
	[scanner scanInt:&green];
	[scanner scanUpToString:@"," intoString:NULL];
	[scanner scanString:@"," intoString:NULL];
	[scanner scanInt:&blue];

	// Check for alpha channel with presence of additional comma
	BOOL hasAlpha = [[rgb substringWithRange:NSMakeRange(scanner.scanLocation, 1)] isEqualToString:@","];
	if (hasAlpha) {
		[scanner scanString:@"," intoString:NULL];
		[scanner scanFloat:&alpha];
	}

	NSColor *color = [NSColor colorWithCalibratedRed:red / 255.0f green:green / 255.f blue:blue / 255.f alpha:alpha];
	
	return color;
}

+ (NSColor *)colorFromCocoaColor:(NSString *)string
{
	// Accepts:
	// [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0]
	// [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0]
	// [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
	
	if (!([string hasPrefix:@"[NSColor colorWith"] || [string hasPrefix:@"[UIColor colorWith"]) || ![string hasSuffix:@"]"]) return nil;
	
	float red = 1.0, green = 1.0, blue = 1.0, alpha = 1.0;
	
	NSScanner *scanner = [[NSScanner alloc] initWithString:string];
	
	[scanner scanUpToString:@":" intoString:NULL];
	[scanner scanString:@":" intoString:NULL];
	[scanner scanFloat:&red];
	[scanner scanUpToString:@":" intoString:NULL];
	[scanner scanString:@":" intoString:NULL];
	[scanner scanFloat:&green];
	[scanner scanUpToString:@":" intoString:NULL];
	[scanner scanString:@":" intoString:NULL];
	[scanner scanFloat:&blue];
	[scanner scanUpToString:@":" intoString:NULL];
	[scanner scanString:@":" intoString:NULL];
	[scanner scanFloat:&alpha];
	
	NSColor *color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
	
	return color;
}

@end
