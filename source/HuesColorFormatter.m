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
	static dispatch_once_t token;
	static NSArray *_tokens = nil;
	dispatch_once(&token, ^{
		_tokens = @[@"{r}", @"{g}", @"{b}", @"{R}", @"{G}", @"{B}", @"{RR}", @"{GG}", @"{BB}", @"{rr}", @"{gg}", @"{bb}", @"{a}"];
	});
	
	return _tokens;
}

+ (NSString *)hexForColor:(NSColor *)color
{
	return [self stringForColor:color withFormat:HEX_FORMAT];
}

+ (NSString *)stringForColorWithDefaultFormat:(NSColor *)color
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
	
	for (NSString *token in [self validTokens]) {
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
		return [NSString stringWithFormat:@"%.3f", color.hues_red / 255.f];
	} else if ([token isEqualToString:@"{g}"]) {
		return [NSString stringWithFormat:@"%.3f", color.hues_green / 255.f];
	} else if ([token isEqualToString:@"{b}"]) {
		return [NSString stringWithFormat:@"%.3f", color.hues_blue / 255.f];
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
