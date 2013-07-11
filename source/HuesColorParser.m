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
		NSLog(@"parsing rgb string");
		[self colorFromRGB:string];
	}
	
	return nil;
}

+ (NSColor *)colorFromHex:(NSString *)hex
{
	// Accepts:
	// #FFFFFF
	// FFFFFF
	// ffffff
	
  // remove any # signs
  hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
  
  if (hex.length < 6) return nil;
  if (hex.length > 6) hex = [hex substringToIndex:6];
  
	NSColor *result = nil;
	unsigned int colorCode = 0;
	unsigned char redByte, greenByte, blueByte;
	
	if (hex != nil) {
		NSScanner *scanner = [NSScanner scannerWithString:hex];
		(void) [scanner scanHexInt:&colorCode];	// ignore error
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
	
	if (![rgb hasPrefix:@"rgb"]) return nil;
	
	int red = 0, green = 0, blue = 0;
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
		
	return [NSColor colorWithCalibratedRed:red / 255.0f green:green / 255.f blue:blue / 255.f alpha:alpha];
}

@end
