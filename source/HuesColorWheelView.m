//
//  HuesColorWheelView.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorWheelView.h"

@interface HuesColorWheelView ()

@property (strong) NSImage *image;
@property (assign) NSRect dragRect;

@end

@implementation HuesColorWheelView

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_color = [NSColor colorWithCalibratedHue:1.0 saturation:1.0 brightness:1.0 alpha:1.0];
		_dragRect = NSZeroRect;
	}
	
	return self;
}

- (void)setColor:(NSColor *)color
{
	if (_color.hueComponent == color.hueComponent) return;

	_color = color;
	[self cacheBitmap];
	[self setNeedsDisplay:YES];
}

- (void)cacheBitmap
{
	CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
	
	CGFloat width = self.bounds.size.width;
	CGFloat height = self.bounds.size.height;
	NSBitmapImageRep *bitRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:width pixelsHigh:height bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace bytesPerRow:0 bitsPerPixel:32];
		
	NSInteger x, y;
	for (x = 0; x < width; x++) {
		for (y = 0; y < height; y++) {
			NSColor *color = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:(x / width) brightness:(y / height) alpha:1.0];
			[bitRep setColor:color atX:x y:y];
		}
	}
  
	self.image = [[NSImage alloc] initWithSize:self.bounds.size];
	[self.image setFlipped:YES];
	[self.image addRepresentation:bitRep];
	
	CFAbsoluteTime elapsed = CFAbsoluteTimeGetCurrent() - start;
	NSLog(@"cache time: %f", elapsed);
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect rect = self.bounds;
	[self.image drawInRect:self.bounds fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
	
//	CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
//	
//	//CGContextRef ctx = [NSGraphicsContext currentContext].graphicsPort;
//	
//	// Loop through each pixel, figure out color, and draw vertical line
//	for (int x = 0; x < NSWidth(rect); x++) {
//		for (int y = 0; y < NSHeight(rect); y++) {
//			NSColor *color = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:(x / NSWidth(rect)) brightness:(y / NSHeight(rect)) alpha:1.0];
//			
//			NSRect rect = NSMakeRect(x, y, 1.0, 1.0);
//			[color set];
//			NSRectFill(rect);
//		}
//	}
//
//	CFAbsoluteTime elapsed = CFAbsoluteTimeGetCurrent() - start;
//	NSLog(@"draw time: %f", elapsed);
	
	[[NSColor whiteColor] set];
	[[NSBezierPath bezierPathWithRect:self.dragRect] stroke];
	
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.25] set];
	[[NSBezierPath bezierPathWithRect:NSInsetRect(rect, 0.5, 0.5)] stroke];
}

- (void)mouseDown:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	CGFloat saturation = point.x / self.bounds.size.width;
	CGFloat brightness = point.y / self.bounds.size.height;
	
	self.dragRect = NSMakeRect(point.x - 1, point.y - 1, 2, 2);
	[self setNeedsDisplay:YES];
	
	if (self.delegate) {
		[self.delegate colorWheelDidChangeSaturation:saturation brightness:brightness];
	}
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	CGFloat saturation = point.x / self.bounds.size.width;
	CGFloat brightness = point.y / self.bounds.size.height;
	
	self.dragRect = NSMakeRect(point.x - 1, point.y - 1, 3, 3);
	[self setNeedsDisplay:YES];
	
	if (self.delegate) {
		[self.delegate colorWheelDidChangeSaturation:saturation brightness:brightness];
	}
}

- (BOOL)mouseDownCanMoveWindow
{
	return NO;
}

@end
