//
//  HuesColorSliderCell.m
//  Hues
//
//  Created by Zach Waugh on 12/14/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorSliderCell.h"
#import "HuesColorSlider.h"

@implementation HuesColorSliderCell

- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped
{
	HuesColorSlider *slider = (HuesColorSlider *)[self controlView];

	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:slider.startColor endingColor:slider.endColor];
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(aRect, 0, 4) xRadius:10 yRadius:10];
	[gradient drawInBezierPath:path angle:0];
	
//	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.1] set];
//	[path stroke];
}

@end
