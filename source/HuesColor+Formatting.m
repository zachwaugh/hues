//
//  HuesColor+Formatting.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor+Formatting.h"

#define HEX_FORMAT @"#{RR}{GG}{BB}"

@implementation HuesColor (Formatting)

+ (NSArray *)validTokens
{
	static dispatch_once_t onceToken;
	static NSArray *_tokens = nil;
	dispatch_once(&onceToken, ^{
		_tokens = [[NSArray alloc] initWithObjects:@"{r}", @"{g}", @"{b}", @"{R}", @"{G}", @"{B}", @"{RR}", @"{GG}", @"{BB}", @"{rr}", @"{gg}", @"{bb}", @"{h}", @"{s}", @"{l}", @"{H}", @"{S}", @"{L}", @"{ss}", @"{br}", @"{BR}", @"{SS}", @"{a}", nil];
	});
	
	return _tokens;
}

- (NSString *)hex
{
	return [self stringWithFormat:HEX_FORMAT];
}

- (NSString *)stringWithFormat:(NSString *)format
{
	NSMutableString *result = [format mutableCopy];
	NSArray *tokens = [self.class validTokens];
	
	for (NSString *token in tokens) {
		NSString *value = [self replacementForToken:token];
		
		if (value) {
			[result replaceOccurrencesOfString:token withString:value options:0 range:NSMakeRange(0, result.length)];
		}
	}
	
	return result;
}

- (NSString *)replacementForToken:(NSString *)token
{
	if ([token isEqualToString:@"{r}"]) {
		return [NSString stringWithFormat:@"%.3f", self.red];
	} else if ([token isEqualToString:@"{g}"]) {
		return [NSString stringWithFormat:@"%.3f", self.green];
	} else if ([token isEqualToString:@"{b}"]) {
		return [NSString stringWithFormat:@"%.3f", self.blue];
	} else if ([token isEqualToString:@"{R}"]) {
		return [NSString stringWithFormat:@"%d", self.hues_red];
	} else if ([token isEqualToString:@"{G}"]) {
		return [NSString stringWithFormat:@"%d", self.hues_green];
	} else if ([token isEqualToString:@"{B}"]) {
		return [NSString stringWithFormat:@"%d", self.hues_blue];
	} else if ([token isEqualToString:@"{RR}"]) {
		return [[NSString stringWithFormat:@"%02x", self.hues_red] uppercaseString];
	} else if ([token isEqualToString:@"{GG}"]) {
		return [[NSString stringWithFormat:@"%02x", self.hues_green] uppercaseString];
	} else if ([token isEqualToString:@"{BB}"]) {
		return [[NSString stringWithFormat:@"%02x", self.hues_blue] uppercaseString];
	} else if ([token isEqualToString:@"{rr}"]) {
		return [NSString stringWithFormat:@"%02x", self.hues_red];
	} else if ([token isEqualToString:@"{gg}"]) {
		return [NSString stringWithFormat:@"%02x", self.hues_green];
	} else if ([token isEqualToString:@"{bb}"]) {
		return [NSString stringWithFormat:@"%02x", self.hues_blue];
	} else if ([token isEqualToString:@"{h}"]) {
		// Hue 0-1 (HSL)
		return [NSString stringWithFormat:@"%.3f", self.hue];
	} else if ([token isEqualToString:@"{s}"]) {
		// Saturation 0-1 (HSL)
		return [NSString stringWithFormat:@"%.3f", self.saturation];
	} else if ([token isEqualToString:@"{l}"]) {
		// Lightness 0-1 (HSL)
		return [NSString stringWithFormat:@"%.3f", self.lightness];
	} else if ([token isEqualToString:@"{ss}"]) {
		// Saturation 0-1 (HSB)
		return [NSString stringWithFormat:@"%.3f", self.HSBSaturation];
	} else if ([token isEqualToString:@"{br}"]) {
		// Brightness 0-1 (HSB)
		return [NSString stringWithFormat:@"%.3f", self.brightness];
	} else if ([token isEqualToString:@"{H}"]) {
		// Hue 0-360 (HSL)
		return [NSString stringWithFormat:@"%d", self.hues_hue];
	} else if ([token isEqualToString:@"{S}"]) {
		// Saturation 0-100 (HSL)
		return [NSString stringWithFormat:@"%d", self.hues_saturation];
	} else if ([token isEqualToString:@"{L}"]) {
		// Lightness 0-100 (HSL)
		return [NSString stringWithFormat:@"%d", self.hues_lightness];
	} else if ([token isEqualToString:@"{SS}"]) {
		// Saturation 0-100 (HSB)
		return [NSString stringWithFormat:@"%d", self.hues_HSBSaturation];
	} else if ([token isEqualToString:@"{BR}"]) {
		// Brightness 0-100 (HSB)
		return [NSString stringWithFormat:@"%d", self.hues_brightness];
	} else if ([token isEqualToString:@"{a}"]) {
		return [NSString stringWithFormat:@"%0.3f", self.alpha];
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
