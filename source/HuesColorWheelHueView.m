//
//  HuesColorWheelHueView.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorWheelHueView.h"
#import "HuesColor.h"

@interface HuesColorWheelHueView ()

@property (nonatomic, assign) CGFloat hue;

@end

@implementation HuesColorWheelHueView

- (void)awakeFromNib
{
	self.hue = 0.0f;
}

- (void)updateColor:(HuesColor *)color
{
	self.hue = color.hue;
}

- (void)setHue:(CGFloat)hue
{
	_hue = hue;
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect rect = self.bounds;
	CGFloat hueY = self.hue * NSHeight(rect);
	
	// Loop through each pixel, figure out color, and draw vertical line
	for (int y = 0; y < NSHeight(rect); y++) {
		NSColor *color = [NSColor colorWithCalibratedHue:(y / NSHeight(rect)) saturation:1.0 brightness:1.0 alpha:1.0];
		NSRect pixel = NSMakeRect(0, y, NSWidth(rect), 1.0);
		[color set];
		NSRectFill(pixel);
	}
	
	// Current hue
	[[NSColor whiteColor] set];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(NSMinX(rect), round(hueY) - 1.5, NSWidth(rect), 2)] stroke];
	
	// Stroke border
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.25] set];
	[[NSBezierPath bezierPathWithRect:NSInsetRect(rect, 0.5, 0.5)] stroke];
}

- (void)mouseDown:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	self.hue = point.y / NSHeight(self.bounds);
	
	if (self.delegate) {
		[self.delegate hueChanged:self.hue];
	}
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	
	if (point.y < NSMinY(self.bounds)) {
		point.y = NSMinY(self.bounds);
	} else if (point.y > NSMaxY(self.bounds)) {
		point.y = NSMaxY(self.bounds);
	}
	
	self.hue = point.y / NSHeight(self.bounds);

	if (self.delegate) {
		[self.delegate hueChanged:self.hue];
	}
}

- (BOOL)mouseDownCanMoveWindow
{
	return NO;
}

@end
