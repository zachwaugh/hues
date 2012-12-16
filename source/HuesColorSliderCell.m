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
	
	NSRect trackRect = NSInsetRect(aRect, 0, 6);
	NSInteger radius = round(trackRect.size.height / 2);
	
	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:slider.startColor endingColor:slider.endColor];
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:trackRect xRadius:radius yRadius:radius];
	[gradient drawInBezierPath:path angle:0];
	
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.25] set];
	[[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(trackRect, 0.5, 0.5) xRadius:radius yRadius:radius] stroke];
}

@end
