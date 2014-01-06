//
//  HuesHueColorSliderCell.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesHueColorSliderCell.h"
#import "HuesHueColorSlider.h"

@implementation HuesHueColorSliderCell

- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped
{
	HuesHueColorSlider *slider = (HuesHueColorSlider *)[self controlView];
	
	NSRect trackRect = NSInsetRect(slider.bounds, 2, 6);
	NSInteger radius = round(trackRect.size.height / 2);

	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:trackRect xRadius:radius yRadius:radius];
	
	[NSGraphicsContext saveGraphicsState];
	[path addClip];
	
	// Loop through each pixel, figure out color, and draw vertical line
	for (int i = 0; i < NSWidth(trackRect); i++) {
		NSColor *color = [NSColor colorWithCalibratedHue:(i / NSWidth(trackRect)) saturation:slider.color.saturationComponent brightness:slider.color.brightnessComponent alpha:1.0];
		
		NSRect rect = NSMakeRect(NSMinX(trackRect) + i, NSMinY(trackRect), 1.0, NSHeight(trackRect));
		[color set];
		NSRectFill(rect);
	}
	
	[NSGraphicsContext restoreGraphicsState];
	
	// Stroke border
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.25] set];
	[[NSBezierPath bezierPathWithRoundedRect:NSInsetRect(trackRect, 0.5, 0.5) xRadius:radius yRadius:radius] stroke];
}
@end
