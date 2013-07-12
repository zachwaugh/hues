//
//  HuesColorParser.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorParser.h"
#import "NSScanner+Hues.h"

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
	
	if (color) {
		NSLog(@"rgb parser found color: %@, for string: %@", color, rgb);
	}
	
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
	
	if (color) {
		NSLog(@"NSColor/UIColor parser found color: %@, for string: %@", color, string);
	}
	
	return color;
}

@end
