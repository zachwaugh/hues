//
//  HuesColorFormatter.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorFormatter.h"
#import "HuesPreferences.h"
#import "NSColor+Hues.h"

#define HEX_FORMAT @"#{RR}{GG}{BB}"

@implementation HuesColorFormatter

+ (NSArray *)validTokens
{
	static dispatch_once_t onceToken;
	static NSArray *_tokens = nil;
	dispatch_once(&onceToken, ^{
		_tokens = [[NSArray alloc] initWithObjects:@"{r}", @"{g}", @"{b}", @"{R}", @"{G}", @"{B}", @"{RR}", @"{GG}", @"{BB}", @"{rr}", @"{gg}", @"{bb}", @"{h}", @"{s}", @"{l}", @"{H}", @"{S}", @"{L}", @"{ss}", @"{br}", @"{BR}", @"{SS}", @"{a}", nil];
	});
	
	return _tokens;
}

+ (NSString *)hexForColor:(NSColor *)color
{
	return [self stringForColor:color withFormat:HEX_FORMAT];
}

+ (NSString *)stringForColorWithPrimaryFormat:(NSColor *)color
{
	NSString *format = [HuesPreferences colorFormats][0][@"format"];
	return [self stringForColor:color withFormat:format];
}

+ (NSString *)stringForColorWithSecondaryFormat:(NSColor *)color
{
	NSString *format = [HuesPreferences colorFormats][1][@"format"];
	return [self stringForColor:color withFormat:format];
}

+ (NSString *)stringForColor:(NSColor *)color withFormat:(NSString *)format
{	
	NSMutableString *result = [format mutableCopy];
	NSArray *tokens = [self validTokens];
	
	for (NSString *token in tokens) {
		NSString *value = [self replacementForToken:token color:color];

		if (value) {
			[result replaceOccurrencesOfString:token withString:value options:0 range:NSMakeRange(0, result.length)];
		}
	}
	
	return result;
}

+ (NSString *)replacementForToken:(NSString *)token color:(NSColor *)color
{
	if ([token isEqualToString:@"{r}"]) {
		return [NSString stringWithFormat:@"%.3f", color.redComponent];
	} else if ([token isEqualToString:@"{g}"]) {
		return [NSString stringWithFormat:@"%.3f", color.greenComponent];
	} else if ([token isEqualToString:@"{b}"]) {
		return [NSString stringWithFormat:@"%.3f", color.blueComponent];
	} else if ([token isEqualToString:@"{R}"]) {
		return [NSString stringWithFormat:@"%d", color.hues_red];
	} else if ([token isEqualToString:@"{G}"]) {
		return [NSString stringWithFormat:@"%d", color.hues_green];
	} else if ([token isEqualToString:@"{B}"]) {
		return [NSString stringWithFormat:@"%d", color.hues_blue];
	} else if ([token isEqualToString:@"{RR}"]) {
		return [[NSString stringWithFormat:@"%02x", color.hues_red] uppercaseString];
	} else if ([token isEqualToString:@"{GG}"]) {
		return [[NSString stringWithFormat:@"%02x", color.hues_green] uppercaseString];
	} else if ([token isEqualToString:@"{BB}"]) {
		return [[NSString stringWithFormat:@"%02x", color.hues_blue] uppercaseString];
	} else if ([token isEqualToString:@"{rr}"]) {
		return [NSString stringWithFormat:@"%02x", color.hues_red];
	} else if ([token isEqualToString:@"{gg}"]) {
		return [NSString stringWithFormat:@"%02x", color.hues_green];
	} else if ([token isEqualToString:@"{bb}"]) {
		return [NSString stringWithFormat:@"%02x", color.hues_blue];
	} else if ([token isEqualToString:@"{h}"]) {
		// Hue 0-1 (HSL)
		return [NSString stringWithFormat:@"%.3f", color.hueComponent];
	} else if ([token isEqualToString:@"{s}"]) {
		// Saturation 0-1 (HSL)
		return [NSString stringWithFormat:@"%.3f", color.hues_saturationComponent];
	} else if ([token isEqualToString:@"{l}"]) {
		// Lightness 0-1 (HSL)
		return [NSString stringWithFormat:@"%.3f", color.hues_lightnessComponent];
	} else if ([token isEqualToString:@"{ss}"]) {
		// Saturation 0-1 (HSB)
		return [NSString stringWithFormat:@"%.3f", color.saturationComponent];
	} else if ([token isEqualToString:@"{br}"]) {
		// Brightness 0-1 (HSB)
		return [NSString stringWithFormat:@"%.3f", color.brightnessComponent];
	} else if ([token isEqualToString:@"{H}"]) {
		// Hue 0-360 (HSL)
		return [NSString stringWithFormat:@"%d", color.hues_hue];
	} else if ([token isEqualToString:@"{S}"]) {
		// Saturation 0-100 (HSL)
		return [NSString stringWithFormat:@"%d", color.hues_saturation];
	} else if ([token isEqualToString:@"{L}"]) {
		// Lightness 0-100 (HSL)
		return [NSString stringWithFormat:@"%d", color.hues_lightness];
	} else if ([token isEqualToString:@"{SS}"]) {
		// Saturation 0-100 (HSB)
		return [NSString stringWithFormat:@"%d", (int)color.saturationComponent * 100];
	} else if ([token isEqualToString:@"{BR}"]) {
		// Brightness 0-100 (HSB)
		return [NSString stringWithFormat:@"%d", color.hues_brightness];
	} else if ([token isEqualToString:@"{a}"]) {
		return [NSString stringWithFormat:@"%0.3f", color.alphaComponent];
	} else {
		// Invalid or unsupported token
		return nil;
	}
}

+ (NSArray *)tokensForColorFormat:(NSString *)format
{
	NSScanner *scanner = [NSScanner scannerWithString:format];
	
	NSMutableArray *tokens = [NSMutableArray array];
	NSString *token = nil;
	
	while (!scanner.isAtEnd) {
		[scanner scanUpToString:@"{" intoString:NULL];
		[scanner scanString:@"{" intoString:NULL];
		
		if ([scanner scanUpToString:@"}" intoString:&token]) {
			[tokens addObject:token];
			token = nil;
		}
		
		[scanner scanString:@"}" intoString:NULL];
	}
	
	return tokens;
}


@end
