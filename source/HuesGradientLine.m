//
//  HuesGradientLine.m
//  Hues
//
//  Created by Zach Waugh on 10/30/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesGradientLine.h"

static NSGradient *line = nil;
static NSGradient *lineHighlight = nil;

static NSGradient *gradientWithTargetColor(NSColor *targetColor)
{
	NSArray *colors = @[[targetColor colorWithAlphaComponent:0], targetColor, targetColor, [targetColor colorWithAlphaComponent:0]];
	const CGFloat locations[4] = { 0.0, 0.2, 0.8, 1.0 };
	return [[NSGradient alloc] initWithColors:colors atLocations:locations colorSpace:[NSColorSpace deviceRGBColorSpace]];
}

@implementation HuesGradientLine

- (void)drawRect:(NSRect)dirtyRect
{
	if (line == nil) {
		line = gradientWithTargetColor([NSColor colorWithCalibratedWhite:0.0 alpha:0.1]);
	}
	
	if (lineHighlight == nil) {
		lineHighlight = gradientWithTargetColor([NSColor colorWithCalibratedWhite:1.0 alpha:0.15]);
	}
	
	float y = round(self.bounds.size.height / 2);
	NSRect rect = NSMakeRect(self.bounds.origin.x, y, self.bounds.size.width, 1);
	[line drawInRect:rect angle:0];
	
	rect.origin.y -= 1;	
	[lineHighlight drawInRect:rect angle:0];
}

@end
