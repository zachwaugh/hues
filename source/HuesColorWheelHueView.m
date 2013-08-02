//
//  HuesColorWheelHueView.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorWheelHueView.h"

@interface HuesColorWheelHueView ()

@property (assign) NSPoint lastDrag;

@end

@implementation HuesColorWheelHueView

- (void)awakeFromNib
{
	self.lastDrag = NSMakePoint(0, 1);
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect rect = self.bounds;
	
	// Loop through each pixel, figure out color, and draw vertical line
	for (int y = 0; y < NSHeight(rect); y++) {
		NSColor *color = [NSColor colorWithCalibratedHue:(y / NSHeight(rect)) saturation:1.0 brightness:1.0 alpha:1.0];
		NSRect pixel = NSMakeRect(0, y, NSWidth(rect), 1.0);
		[color set];
		NSRectFill(pixel);
	}
	
	// Current hue
	[[NSColor whiteColor] set];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(NSMinX(rect), round(self.lastDrag.y) - 1.5, NSWidth(rect), 2)] stroke];
	
	// Stroke border
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.25] set];
	[[NSBezierPath bezierPathWithRect:NSInsetRect(rect, 0.5, 0.5)] stroke];
}

- (void)mouseDown:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	self.lastDrag = point;
	[self setNeedsDisplay:YES];
	CGFloat hue = point.y / self.bounds.size.height;
	
	if (self.delegate) {
		[self.delegate hueChanged:hue];
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
	
	self.lastDrag = point;
	[self setNeedsDisplay:YES];
	
	CGFloat hue = point.y / self.bounds.size.height;
	
	if (self.delegate) {
		[self.delegate hueChanged:hue];
	}
}

- (BOOL)mouseDownCanMoveWindow
{
	return NO;
}

@end
